import 'package:rservation_user/features/list_of_category_details/data_layer/item_package_model.dart';

class API{
  static  const baseURL = "https://quizzy.site/reservation_app";
  static  const login = "/user/login.php";
  static const signup = "/user/add_user.php";
  static const getCategories ="/category/get_category.php";
  static const getCategoryItem='/category/get_category_items.php';
  static const getUserReservations ='/reservations/get_user_reservations.php';
  static const userUpdateData ='/user/edit_user.php';
  static const itemOptions ='/item/get_item_options.php';
  static const addReservation ='/reservations/add_reservation.php';
  static const deleteReservation="/reservations/delete_reservation.php";
  static const updateReservation="/reservations/edit_reservation.php";
  static const calenderData="/user/calender.php";
  static const itemPackage ='/item/get_item_available_time.php';

  // static const validateEmail = "/user/validate_email.php";
  // static const update ="/user/updateName.php";
}
