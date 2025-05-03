from datetime import timedelta

import polars as pl

from schema import datetime_cn

def add_missing_datetime(
        df: pl.DataFrame,
        main_duration: timedelta,
):
    st_s = df[datetime_cn].sort()

    full_st_s = pl.datetime_range(
        st_s.first(),
        st_s.last(),
        main_duration,
        eager=True,
    ).alias(datetime_cn)

    assert full_st_s.first() == st_s.first() and full_st_s.last() == st_s.last(), 'ranges must match'

    time_unit = df[datetime_cn].dtype.time_unit
    full_df = full_st_s.cast(pl.Datetime(time_unit=time_unit)).to_frame()
    full_df = full_df.join(df, on=datetime_cn, how='left')

    return full_df

