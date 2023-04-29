
class OrderDetailsModel {
  int _id;
  int _productId;
  int _orderId;
  double _price;
  ProductDetails _productDetails;
  List<OldVariation> _oldVariations;
  List<Variation> _variations;
  double _discountOnProduct;
  String _discountType;
  int _quantity;
  double _taxAmount;
  String _createdAt;
  String _updatedAt;
  List<int> _addOnIds;
  List<int> _addOnQtys;

  OrderDetailsModel(
      {int id,
        int productId,
        int orderId,
        double price,
        ProductDetails productDetails,
        List<OldVariation> oldVariations,
        List<Variation> variations,
        double discountOnProduct,
        String discountType,
        int quantity,
        double taxAmount,
        String createdAt,
        String updatedAt,
        List<int> addOnIds,
        List<int> addOnQtys,
      }) {
    this._id = id;
    this._productId = productId;
    this._orderId = orderId;
    this._price = price;
    this._productDetails = productDetails;
    this._oldVariations = oldVariations;
    this._variations = variations;
    this._discountOnProduct = discountOnProduct;
    this._discountType = discountType;
    this._quantity = quantity;
    this._taxAmount = taxAmount;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._addOnIds = addOnIds;
    this._addOnQtys = addOnQtys;
  }

  int get id => _id;
  int get productId => _productId;
  int get orderId => _orderId;
  double get price => _price;
  ProductDetails get productDetails => _productDetails;
  List<OldVariation> get oldVariations => _oldVariations;
  List<Variation> get variations => _variations;
  double get discountOnProduct => _discountOnProduct;
  String get discountType => _discountType;
  int get quantity => _quantity;
  double get taxAmount => _taxAmount;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<int> get addOnIds => _addOnIds;
  List<int> get addOnQtys => _addOnQtys;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _orderId = json['order_id'];
    _price = json['price'].toDouble();
    _productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    if (json['variation'] != null && json['variation'].isNotEmpty) {
      if(json['variation'][0]['values'] != null) {
        _variations = [];
        json['variation'].forEach((v) {
          _variations.add(new Variation.fromJson(v));
        });
      }else{
        _oldVariations = [];
        json['variation'].forEach((v) {
          _oldVariations.add(new OldVariation.fromJson(v));
        });
      }
    }
    _discountOnProduct = json['discount_on_product'].toDouble();
    _discountType = json['discount_type'];
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'].toDouble();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _addOnIds = json['add_on_ids'].cast<int>();
    _addOnQtys = json['add_on_qtys'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['order_id'] = this._orderId;
    data['price'] = this._price;
    if (this._productDetails != null) {
      data['product_details'] = this._productDetails.toJson();
    }
    if (this._variations != null) {
      data['variation'] = this._variations;
    }
    data['discount_on_product'] = this._discountOnProduct;
    data['discount_type'] = this._discountType;
    data['quantity'] = this._quantity;
    data['tax_amount'] = this._taxAmount;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['add_on_ids'] = this._addOnIds;
    data['add_on_qtys'] = this._addOnQtys;
    return data;
  }
}

class ProductDetails {
  int _id;
  String _name;
  String _description;
  String _image;
  double _price;
  List<Variation> _variations;
  List<OldVariation> _oldVariation;
  List<AddOns> _addOns;
  double _tax;
  String _availableTimeStarts;
  String _availableTimeEnds;
  int _status;
  String _createdAt;
  String _updatedAt;
  List<String> _attributes;
  List<CategoryIds> _categoryIds;
  List<ChoiceOptions> _choiceOptions;
  double _discount;
  String _discountType;
  String _taxType;
  int _setMenu;
  String _productType;

  ProductDetails(
      {int id,
        String name,
        String description,
        String image,
        double price,
        List<Variation> variations,
        List<OldVariation> oldVariation,
        List<AddOns> addOns,
        double tax,
        String availableTimeStarts,
        String availableTimeEnds,
        int status,
        String createdAt,
        String updatedAt,
        List<String> attributes,
        List<CategoryIds> categoryIds,
        List<ChoiceOptions> choiceOptions,
        double discount,
        String discountType,
        String taxType,
        int setMenu,
        String productType,
      }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._image = image;
    this._price = price;
    this._variations = variations;
    this._oldVariation = oldVariation;
    this._addOns = addOns;
    this._tax = tax;
    this._availableTimeStarts = availableTimeStarts;
    this._availableTimeEnds = availableTimeEnds;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._attributes = attributes;
    this._categoryIds = categoryIds;
    this._choiceOptions = choiceOptions;
    this._discount = discount;
    this._discountType = discountType;
    this._taxType = taxType;
    this._setMenu = setMenu;
    this._productType = productType;
  }

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get image => _image;
  double get price => _price;
  List<Variation> get variations => _variations;
  List<OldVariation> get oldVariations => _oldVariation;
  List<AddOns> get addOns => _addOns;
  double get tax => _tax;
  String get availableTimeStarts => _availableTimeStarts;
  String get availableTimeEnds => _availableTimeEnds;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<String> get attributes => _attributes;
  List<CategoryIds> get categoryIds => _categoryIds;
  List<ChoiceOptions> get choiceOptions => _choiceOptions;
  double get discount => _discount;
  String get discountType => _discountType;
  String get taxType => _taxType;
  int get setMenu => _setMenu;
  String get productType => _productType;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _price = json['price'].toDouble();
    if (json['variation'] != null && json['variation'].isNotEmpty) {
      if(json['variation'][0]['values'] != null) {
        _variations = [];
        json['variation'].forEach((v) {
          _variations.add(Variation.fromJson(v));
        });
      }else{
        _oldVariation = [];
        json['variation'].forEach((v) {
          _oldVariation.add(new OldVariation.fromJson(v));
        });
      }
    }
    if (json['add_ons'] != null) {
      _addOns = [];
      json['add_ons'].forEach((v) {
        _addOns.add(new AddOns.fromJson(v));
      });
    }
    _tax = json['tax'].toDouble();
    _availableTimeStarts = json['available_time_starts'];
    _availableTimeEnds = json['available_time_ends'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _attributes = json['attributes'].cast<String>();
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds.add(new CategoryIds.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions.add(new ChoiceOptions.fromJson(v));
      });
    }
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _taxType = json['tax_type'];
    _setMenu = json['set_menu'];
    _productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['image'] = this._image;
    data['price'] = this._price;
    if (this._variations != null) {
      data['variations'] = this._variations.map((v) => v.toJson()).toList();
    }
    if (this._addOns != null) {
      data['add_ons'] = this._addOns.map((v) => v.toJson()).toList();
    }
    data['tax'] = this._tax;
    data['available_time_starts'] = this._availableTimeStarts;
    data['available_time_ends'] = this._availableTimeEnds;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['attributes'] = this._attributes;
    if (this._categoryIds != null) {
      data['category_ids'] = this._categoryIds.map((v) => v.toJson()).toList();
    }
    if (this._choiceOptions != null) {
      data['choice_options'] =
          this._choiceOptions.map((v) => v.toJson()).toList();
    }
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['tax_type'] = this._taxType;
    data['set_menu'] = this._setMenu;
    data['product_type'] = this._productType;
    return data;
  }
}
class VariationValue {
  String level;
  double optionPrice;

  VariationValue({this.level, this.optionPrice});

  VariationValue.fromJson(Map<String, dynamic> json) {
    level = json['label'];
    optionPrice = double.parse(json['optionPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.level;
    data['optionPrice'] = this.optionPrice;
    return data;
  }
}

class Variation {
  String name;
  int min;
  int max;
  bool isRequired;
  bool isMultiSelect;
  List<VariationValue> variationValues;


  Variation({
    this.name, this.min, this.max,
    this.isRequired, this.variationValues,
    this.isMultiSelect,
  });

  Variation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isMultiSelect = '${json['type']}' == 'multi';
    min =  isMultiSelect ? int.parse(json['min'].toString()) : 0;
    max = isMultiSelect ? int.parse(json['max'].toString()) : 0;
    isRequired = '${json['required']}' == 'on';
    if (json['values'] != null) {
      variationValues = [];
      json['values'].forEach((v) {
        variationValues.add(new VariationValue.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.isMultiSelect;
    data['min'] = this.min;
    data['max'] = this.max;
    data['required'] = this.isRequired;
    if (this.variationValues != null) {
      data['values'] = this.variationValues.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AddOns {
  int _id;
  String _name;
  double _price;
  String _createdAt;
  String _updatedAt;

  AddOns(
      {int id, String name, double price, String createdAt, String updatedAt}) {
    this._id = id;
    this._name = name;
    this._price = price;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  AddOns.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'].toDouble();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['price'] = this._price;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class CategoryIds {
  String _id;
  int _position;

  CategoryIds({String id, int position}) {
    this._id = id;
    this._position = position;
  }

  String get id => _id;
  int get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['position'] = this._position;
    return data;
  }
}

class ChoiceOptions {
  String _name;
  String _title;
  List<String> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name;
  String get title => _title;
  List<String> get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class OldVariation {
  String type;
  double price;

  OldVariation({this.type, this.price});

  OldVariation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}
