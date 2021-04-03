import 'package:antonx/core/models/blog.dart';
import 'package:antonx/core/view_models/base_view_model.dart';

class AddEditBlogViewModel extends BaseViewModel{
  Blog blog;

  AddEditBlogViewModel({Blog blg}){
    if(blg == null){
      blog = Blog();
    } else{
      blog = blg;
    }
  }

}