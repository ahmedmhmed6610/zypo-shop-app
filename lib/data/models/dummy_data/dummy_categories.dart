import 'package:shop/data/models/category_model.dart';

List<CategoryModel> categoryListItems() => <CategoryModel>[
      CategoryModel(
          id: 1,
          parentId: 0,
          image:
              "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
          name: null,
          isParent: 1),
      CategoryModel(
        id: 2,
        parentId: 0,
        image:
            "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
        isParent: 1,
        name: null,
      ),
      CategoryModel(
        id: 3,
        parentId: 0,
        isParent: 1,
        image:
            "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
        name: null,
      ),
      CategoryModel(
        id: 4,
        parentId: 0,
        image:
            "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
        isParent: 1,
        name: null,
      ),
      CategoryModel(
        id: 5,
        parentId: 0,
        image:
            "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
        isParent: 1,
        name: null,
      )
    ];

Map<int, List<CategoryModel>> categoryByParentItems() => {
      1: [
        CategoryModel(
            id: 100,
            parentId: 1,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            isParent: 0,
            name: null),
        CategoryModel(
            id: 101,
            parentId: 1,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
        CategoryModel(
            id: 102,
            parentId: 1,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
      ],
      2: [
        CategoryModel(
            id: 200,
            parentId: 2,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
        CategoryModel(
            id: 201,
            parentId: 2,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
        CategoryModel(
            id: 202,
            parentId: 2,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
        CategoryModel(
            id: 203,
            parentId: 2,
            isParent: 0,
            image:
                "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg",
            name: null),
      ],
      3: [],
      4: [],
      5: [],
    };
