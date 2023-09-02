// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    List<User>? users;
    List<Game>? game;
    List<Cart>? cart;

    Data({
        this.users,
        this.game,
        this.cart,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["Users"] == null ? [] : List<User>.from(json["Users"]!.map((x) => User.fromJson(x))),
        game: json["Game"] == null ? [] : List<Game>.from(json["Game"]!.map((x) => Game.fromJson(x))),
        cart: json["Cart"] == null ? [] : List<Cart>.from(json["Cart"]!.map((x) => Cart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "Game": game == null ? [] : List<dynamic>.from(game!.map((x) => x.toJson())),
        "Cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
    };
}

class Cart {
    int? id;
    int? gameId;
    String? gameTitle;
    String? gamePrice;
    String? gamePicture;
    String? total;

    Cart({
        this.id,
        this.gameId,
        this.gameTitle,
        this.gamePrice,
        this.gamePicture,
        this.total,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        gameId: json["Game_id"],
        gameTitle: json["Game_title"],
        gamePrice: json["Game_price"],
        gamePicture: json["Game_picture"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Game_id": gameId,
        "Game_title": gameTitle,
        "Game_price": gamePrice,
        "Game_picture": gamePicture,
        "total": total,
    };
}

class Game {
    int? id;
    String? title;
    String? type;
    String? price;
    String? detail;
    String? picture;

    Game({
        this.id,
        this.title,
        this.type,
        this.price,
        this.detail,
        this.picture,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        price: json["price"],
        detail: json["detail"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "price": price,
        "detail": detail,
        "picture": picture,
    };
}

class User {
    int? id;
    String? email;
    String? password;

    User({
        this.id,
        this.email,
        this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
    };
}
