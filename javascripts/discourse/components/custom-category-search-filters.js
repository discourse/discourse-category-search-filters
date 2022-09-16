import Component from "@glimmer/component";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import { getOwner } from "discourse-common/lib/get-owner";

export default class searchFilters extends Component {
  @service site;

  @action
  filterSearch(slug) {
    const searchController = getOwner(this).lookup(
      "controller:full-page-search"
    );

    let hashSlug = `#${slug}`;
    let categoryRegex = new RegExp(`${hashSlug}`, "g");
    let searchTerm = searchController.searchTerm;

    if (searchTerm.match(categoryRegex)) {
      searchTerm = searchController.searchTerm.replace(categoryRegex, "");
    } else {
      searchTerm = `${searchTerm} #${slug}`;
    }

    searchController.set("searchTerm", searchTerm.replace(/\s\s+/g, " "));

    searchController.send("search");
  }
}
