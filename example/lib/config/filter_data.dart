
/// TODO : 元数据
/// TODO : title字段专门给回显值留下的
/// @param
/// @return
/// @author 丁平
/// created at 2021/1/11 15:38
///
class FilterData{
  static  List<Map<String,dynamic>>  sort = [
    {'key': '-1','value' : '默认' ,'title' : '排序' },
    {'key': '{inputTime} desc','value' : '最新发布','title' : '最新发布'  },
    {'key': '{look} desc','value' : '带看最多','title' : '带看最多'  },
    {'key': '{latestFollow} desc','value' : '最新跟进','title' : '最新跟进'  },
    {'key': '{price} desc','value' : '价格从高到低','title' : '价格从高到低'  },
    {'key': '{price} asc','value' : '价格从低到高' ,'title' : '价格从低到高' },
    {'key': '{area} desc','value' : '面积从高到低','title' : '面积从高到低'  },
    {'key': '{area} asc','value' : '面积从低到高' ,'title' : '面积从低到高' },
  ];
  static List<Map<String,dynamic>>  ranges = [
    {'key': '-1','value' : '不限','title' : '范围' },
    {'key': '0','value' : '共享范围内','title' : '共享范围内' },
    {'key': '1','value' : '共享范围外','title' : '共享范围外' },
  ];
  static List<Map<String,dynamic>>  housingTypes = [
    {'key': '-1','value' : '不限' },
    {'key': '000','value' : '出售' },
    {'key': '1111','value' : '出租' },
  ];
  static List<Map<String,dynamic>>  amount = [
    {'key': '-1','value' : '不限' },
    {'key': '50>','value' : '50万以下' },
    {'key': '80> 50','value' : '50-80万' },
    {'key': '100> 80','value' : '80-8100万' },
    {'key': '150> 100','value' : '100-150万' },
    {'key': '200> 150','value' : '150-200万' },
    {'key': '>200 ','value' : '200万以上' },
  ];

  static List<Map<String,Object>> moreListMap = [
    {'key' : '-1','value' : '不限'},
    {'key' : 11725 ,'value' :  '一般'},
    {'key' :  11726,'value' :  '紧迫'},
    {'key' : 11727,'value' :  '非常紧迫'},
  ];
}