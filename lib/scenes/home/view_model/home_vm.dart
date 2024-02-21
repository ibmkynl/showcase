import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:showcase/api/api.dart";
import "package:showcase/models/page_model.dart";

final homeProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    loadPage();
  }

  final Api _api = Api();

  ///stores all pages and users, accessible from anywhere
  List<PageModel> pageList = [];

  ///1 as default, once we learn how many pages are there, this will help us to not fetch same users over and over
  int totalPages = 1;

  ///api starts from 1
  int currentPage = 1;

  Future<void> loadPage() async {
    PageModel? model = await _api.getPage(page: currentPage);

    if (model == null) return;

    totalPages = model.totalPages;

    pageList.add(model);
    notifyListeners();
  }

  ///It only fetch pages via API if they are visited for the first time.
  ///Afterwards it always shows through the list.
  Future<void> nextPage() async {
    //helps to not overrun number of pages
    if (currentPage >= totalPages) return;

    currentPage++;

    if (pageList.length >= currentPage) {
      notifyListeners();
      return;
    }

    await loadPage();
  }

  ///previous pages already in our list, we don't need to fetch again.
  Future<void> previousPage() async {
    //stop at first page
    if (currentPage <= 1) return;

    currentPage--;

    notifyListeners();
  }
}
