# fultter-component
fultter一些自已做的控件,加快业务开发，减少嵌套代码
1. ContainerLR 左中右布局控件或上中下布局控件
2. ContainerBars 跟据一个List生成一排控件，比如菜单

Demo
1.ContainerLR  左中右布局控件或上中下布局控件
属性介绍:
  1.1 itemLeft 左边容器当为null时,默认是Container,如果有值一定要return widget
  1.2 itemMid  中边容器
  1.3 itemRight右边容器
  1.4 itemVertical 默认false,水平布局，开启垂直布局
ContainerLR(
              height: 60,
              itemExpandedMode: TExpandLRMode.left, //左边容器最大化
              itemLeft: (_) {
                return Container(
                   
                );
              },
              itemRight: (_) {
                 return Container(
                  
                );
              },
            )

2.ContainerBars  跟据一个List生成一排控件，比如菜单
属性介绍
  2.1  itemList挂载的对象
  2.2  itemChild 生成的控件
  2.3  onTap 点击子控件的回调事件
  2.4  onSetData 当itemList为null时,会调用此事件,可以写获取数据的方法，并回调通知控件更新
ContainerBars<TMJProductType>(
          itemList: _uCMJSaleBillData.productTypeList,
          onSetData: (qCallBack) {
            //HTTP 打开数据
            TOpenDataHelp.openDataGetMJProductTypeList(qOnSuccess: (qResult) {
              _uCMJSaleBillData.productTypeList = qResult.ResultObject;
              if (_uCMJSaleBillData.productTypeList != null) {
                _uCMJSaleBillData.productTypeList = _uCMJSaleBillData.productTypeList.where((item) => item.FTypeClass == "类别").toList();
              }
              //回调通知
              qCallBack(_uCMJSaleBillData.productTypeList);
            }, qOnErr: (qResult) {
              TMsgHelp.showToast(context, qResult.getResultMsg());
            });
          },
          decoration: TDecorationHelp.myDecoration(qTag: [TBDTag.bottom]),
          height: 60,
          itemChild: (itemChild) {
            return Container(
              alignment: Alignment.center,
              width: 100,
              child: Text(itemChild.FTypeName),
            );
          },
          onTap: (itemChild) {
            print(itemChild.FTypeName);
          },
        )
