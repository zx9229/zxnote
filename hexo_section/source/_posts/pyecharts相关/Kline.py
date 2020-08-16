import datetime
import numpy
import pandas
import pyecharts

if __name__ == '__main__':
    # #########################################################################
    print('pyecharts.__version__ = {}'.format(pyecharts.__version__))
    pyecharts.globals._WarningControl.ShowWarning = False
    # #########################################################################
    SH000300Data = [{
        'date': numpy.datetime64(datetime.date(2005, 12, 30)),
        'open': 994.76,
        'close': 923.45,
        'low': 807.78,
        'high': 1059.48
    }, {
        'date': numpy.datetime64(datetime.date(2006, 12, 29)),
        'open': 926.55,
        'close': 2041.05,
        'low': 926.41,
        'high': 2052.86
    }, {
        'date': numpy.datetime64(datetime.date(2007, 12, 28)),
        'open': 2073.25,
        'close': 5338.28,
        'low': 2030.76,
        'high': 5891.72
    }, {
        'date': numpy.datetime64(datetime.date(2008, 12, 31)),
        'open': 5349.76,
        'close': 1817.72,
        'low': 1606.73,
        'high': 5756.92
    }]
    SH000300DataFrame = pandas.DataFrame(SH000300Data)
    # #########################################################################
    dfX = SH000300DataFrame['date']
    # (numpy.datetime64)转(datetime.datetime)
    dataX = dfX.values.astype('datetime64[s]').tolist()
    #
    dfY = SH000300DataFrame.loc[:, ['open', 'close', 'low', 'high']]
    # (numpy.ndarray)转(list)
    dataY = dfY.values.tolist()
    # #########################################################################
    pyecharts.charts.Kline().add_xaxis(xaxis_data=dataX).add_yaxis(
        series_name='年K线',
        y_axis=dataY,
    ).set_global_opts(datazoom_opts=[
        pyecharts.options.DataZoomOpts(type_="slider",
                                       orient="horizontal"),  # 水平滑动条,
        pyecharts.options.DataZoomOpts(type_="slider",
                                       orient="vertical"),  # 垂直滑动条,
        pyecharts.options.DataZoomOpts(type_="inside"),  # 鼠标滚轮可缩放,
    ]).render(__file__ + '.html')
    # #########################################################################
    exit(0)
