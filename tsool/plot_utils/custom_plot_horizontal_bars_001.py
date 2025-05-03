import calendar
from datetime import timedelta

import numpy as np
import polars as pl
from matplotlib import pyplot as plt, ticker
import seaborn as sns
from datetime import datetime

from schema import *


def plot_categories(
        X: pl.Series,
        Y: pl.Series,
        y_ticks_map: dict,
        ax: plt.Axes,
        xlabel: str = None,
        ylabel: str = None,
        negative_color=(238 / 255, 78 / 255, 78 / 255),
        positive_color=(161 / 255, 221 / 255, 112 / 255),

):
    ax.set_xlabel(xlabel, fontsize=24)
    ax.xaxis.set_label(xlabel)
    ax.set_ylabel(ylabel, fontsize=24, labelpad=80)
    ax.yaxis.set_label(ylabel)
    ax.tick_params(axis='y', which='major', pad=0, labelsize=18)
    ax.tick_params(axis='x', which='major', pad=0, labelsize=18)
    ax.grid(visible=True, which='major', axis='both', color='black', alpha=0.2)
    # sns.set_color_codes("muted")

    colors = [np.array(negative_color) * abs(x / X.min()) if x < 0 else np.array(positive_color) * abs(x / X.max()) for
              x in X]

    sns.barplot(
        ax=ax,
        x=X,
        y=Y,
        hue=X,
        # label="Alcohol-involved",
        palette=colors,
        orient='h'
    )

    ax.xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f"${x:,.2f}"))
    ax.yaxis.set_major_formatter(plt.FuncFormatter(lambda i, _: f"{y_ticks_map[Y[i]]}"))

    for i in ax.containers:
        ax.bar_label(i, fmt='   ${:,.0f}   ', fontsize=18)

    ax.margins(0.15)
    ax.legend([], [], frameon=False)

    sns.despine(left=True, bottom=True)


def investment_categories_and_revenue(
        inv_cat_x: pl.Series,
        inv_cat_y: pl.Series,
        revenue_x: pl.Series,
        revenue_y: pl.Series,

        y_ticks_map: dict,
        inv_cat_xlabel: str = None,
        inv_cat_ylabel: str = None,
        revenue_xlabel: str = None,
        revenue_ylabel: str = None,
        title: str = None,
        figsize=(20, 15),
        inv_cat_negative_color=np.array([238, 78, 78]) / 255,
        inv_cat_positive_color=np.array([238, 78, 78]) / 255,
        revenue_negative_color=np.array([121, 221, 126]) / 255,
        revenue_positive_color=np.array([121, 221, 126]) / 255,
        height_ratios=(5, 1)
):
    fig, axs = plt.subplots(2, 1, gridspec_kw={'height_ratios': height_ratios}, figsize=figsize, sharex=True)
    fig.suptitle(title, fontsize=24, y=1.0, x=1.0, ha='right')
    # fig.supylabel("Categoria", fontsize = 24, x=0.0, y=0.5, )
    # fig.supxlabel("Monto", fontsize = 24)

    inv_cat_ax = axs[0]
    revenue_ax = axs[1]
    plot_categories(
        X=inv_cat_x,
        Y=inv_cat_y,
        y_ticks_map=y_ticks_map,
        ax=inv_cat_ax,
        xlabel=inv_cat_xlabel,
        ylabel=inv_cat_ylabel,
        negative_color=inv_cat_negative_color,
        positive_color=inv_cat_positive_color,
    )

    plot_categories(
        X=revenue_x,
        Y=revenue_y,
        y_ticks_map=y_ticks_map,
        ax=revenue_ax,
        xlabel=revenue_xlabel,
        ylabel=revenue_ylabel,
        negative_color=revenue_negative_color,
        positive_color=revenue_positive_color,
    )

    plt.show()


def plot_report(
        operations: pl.DataFrame,
        debt: float,
        car_depreciation: float,
        operation_days: timedelta,
        y_ticks_map: dict,
        revenue_columns=(
                taxes_cv,
                car_gps_cv,
                life_insurance_cn,
                extended_guarantee_cv,
                business_expenses_cv,
                maintenance_cv,
                car_insurance_cn,
                monthly_interests_cv,
                revenue_cv,
                monthly_car_interest_payment_cv,
                monthly_car_loan_taxes_cv,
                monthly_life_insurance_capital_repayment_cv,
                monthly_life_insurance_interest_payment_cv,
                monthly_life_insurance_loan_taxes_cv,
                monthly_car_insurance_capital_repayment_cv,
                monthly_car_insurance_interest_payment_cv,
                monthly_car_insurance_loan_taxes_cv
        )
):
    # We are going to adjust (i.e take into account the part of the insurance that is still usable) insurances

    by_ope_type_df = operations.group_by(ope_type_cn).agg(pl.col(amount_cn).sum()).sort(amount_cn, descending=False)
    investment_df = pl.concat([
        by_ope_type_df.filter(pl.col(ope_type_cn) != revenue_cv).with_columns(
            pl.col(amount_cn).abs()
        ),
        pl.DataFrame([{
            ope_type_cn: debt_cv,
            amount_cn: debt
        }])
    ]).sort(amount_cn)
    total_invested = investment_df[amount_cn].sum()

    adjusted_operations = operations.with_columns(

        pl.when(pl.col(ope_type_cn) == car_insurance_cn)
        .then(
            (((datetime.now() - pl.col(datetime_cn)).dt.total_days() / (365))
             .clip(0, 1) * pl.col(amount_cn))
        )
        .otherwise(pl.col(amount_cn))
        .alias(amount_cn),

    )
    adjusted_operations = adjusted_operations.with_columns(

        pl.when(pl.col(ope_type_cn) == life_insurance_cn)
        .then(
            (((datetime.now() - pl.col(datetime_cn)).dt.total_days() / (365 * 5))
             .clip(0, 1) * pl.col(amount_cn))
        )
        .otherwise(pl.col(amount_cn))
        .alias(amount_cn),

    )

    by_ope_type_df = adjusted_operations.group_by(ope_type_cn).agg(pl.col(amount_cn).sum()).sort(amount_cn,
                                                                                                 descending=False)

    revenue_df = pl.concat([
        pl.DataFrame([{
            ope_type_cn: depreciation_cv,
            amount_cn: -car_depreciation,
        }]),
        by_ope_type_df.filter(
            pl.col(ope_type_cn).is_in(revenue_columns)
        ),
    ]).sort(amount_cn)

    adjusted_revenue = revenue_df[amount_cn].sum()

    roi = adjusted_revenue / total_invested
    weeks = operation_days.days / 7

    comp_roi = (roi + 1) ** (1 / weeks) - 1
    rjust = 18

    title = f"""
        Years:{f'{(operation_days.days / 365):,.2f}'.rjust(rjust + 6)}
        Weeks:{f'{weeks:,.2f}'.rjust(rjust + 6)}
        Retorno ajustado:{f'${adjusted_revenue:,.2f}'.rjust(rjust + 1)}
        Inversion:{f'${total_invested:,.2f}'.rjust(rjust)}
        Retorno simple:{f'{roi:,.2%}'.rjust(rjust + 3)}
        Retorno semana:{f'{comp_roi:,.2%}'.rjust(rjust + 4)}
    """

    investment_categories_and_revenue(
        inv_cat_x=investment_df[amount_cn],
        inv_cat_y=investment_df[ope_type_cn],
        revenue_x=revenue_df[amount_cn],
        revenue_y=revenue_df[ope_type_cn],
        y_ticks_map=y_ticks_map,
        inv_cat_xlabel=" ",
        inv_cat_ylabel="Inversion",
        revenue_xlabel=" ",
        revenue_ylabel="Retorno",
        title=title,
        height_ratios=(3, 3),
        inv_cat_negative_color=np.array([136, 141, 218]) / 255,
        inv_cat_positive_color=np.array([33, 182, 182]) / 255,
        revenue_negative_color=np.array([223, 54, 45]) / 255,
        revenue_positive_color=np.array([50, 205, 48]) / 255,
    )
