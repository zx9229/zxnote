# 根据以下链接的内容编写了下述代码
# http://gallery.pyecharts.org/#/Candlestick/professional_kline_brush
import pandas
import pyecharts
import typing


def load_data(filename):
    '''
    内容大致如下所示:
    exchange,symbol,time,open,high,low,close,volume,open_interest
    CFFEX,IFL8,2018-01-02 09:31:00,4051.60,4060.40,4051.60,4060.00,398,24365
    CFFEX,IFL8,2018-01-02 09:32:00,4060.20,4062.20,4058.60,4060.00,212,24241
    '''
    DataFrame_data = pandas.read_csv(filename)
    return DataFrame_data


def calculate_ma(day_count: int, data):
    """ data 是类似 [('时间戳1', '数据1'), ('时间戳2', '数据2')] 的数据 """
    result: typing.List[typing.Union[float, str]] = []
    for i in range(len(data)):
        if i < day_count:
            result.append("-")
            continue
        sum_total = 0.0
        for j in range(day_count):
            sum_total += float(data[i - j][1])
        result.append(float("%.4f" % (sum_total / day_count)))
    return result


def get_charts_Kline(DataFrame_data):
    Series_dataX = DataFrame_data['time']
    list_dataX = Series_dataX.values.astype('datetime64[s]').tolist()
    Series_dataY = DataFrame_data.loc[:, ['open', 'close', 'low', 'high']]
    list_dataY = Series_dataY.values.tolist()
    #
    kline = pyecharts.charts.Kline(
    ).add_xaxis(xaxis_data=list_dataX).add_yaxis(
        series_name='K线',
        y_axis=list_dataY,
    ).set_global_opts(
        datazoom_opts=[
            pyecharts.options.DataZoomOpts(type_="slider",
                                           orient="horizontal"),  # 水平滑动条,
            pyecharts.options.DataZoomOpts(type_="slider",
                                           orient="vertical"),  # 垂直滑动条,
            pyecharts.options.DataZoomOpts(type_="inside", ),  # 鼠标滚轮可缩放,
        ],
        tooltip_opts=pyecharts.options.TooltipOpts(  # 在一个提示框里显示所有图表的数值._______
            trigger="axis",
            axis_pointer_type="cross",
            background_color="rgba(245, 245, 245, 0.8)",
            border_width=1,
            border_color="#ccc",
            textstyle_opts=pyecharts.options.TextStyleOpts(color="#000"),
        ),
        brush_opts=pyecharts.options.BrushOpts(  # 显示(矩形选择,圈选,保持选择,清除选择)
            x_axis_index="all",
            brush_link="all",
            out_of_brush={"colorAlpha": 0.1},
            brush_type="lineX",
        ),
    )
    #
    return kline


def get_charts_Line(DataFrame_data):
    Series_dataX = DataFrame_data['time']
    list_dataX = Series_dataX.values.astype('datetime64[s]').tolist()
    Series_dataY = DataFrame_data.loc[:, ['time', 'close']]
    #
    line = pyecharts.charts.Line().add_xaxis(xaxis_data=list_dataX).add_yaxis(
        series_name="MA10",
        y_axis=calculate_ma(day_count=10, data=Series_dataY.values),
        label_opts=pyecharts.options.LabelOpts(is_show=False),
    ).add_yaxis(
        series_name="MA20",
        y_axis=calculate_ma(day_count=20, data=Series_dataY.values),
        label_opts=pyecharts.options.LabelOpts(is_show=False),
    )
    #
    return line


if __name__ == '__main__':
    # #########################################################################
    print('pyecharts.__version__ = {}'.format(pyecharts.__version__))
    pyecharts.globals._WarningControl.ShowWarning = False
    # #########################################################################
    filename = 'data.txt'
    data_in_DataFrame = load_data(filename)
    # #########################################################################
    charts_kline = get_charts_Kline(data_in_DataFrame)
    charts_line = get_charts_Line(data_in_DataFrame)
    charts_kline.overlap(charts_line)
    charts_kline.render(__file__ + '.html')
    # #########################################################################
    exit(0)
