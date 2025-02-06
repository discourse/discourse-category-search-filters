import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { getOwner } from "discourse/lib/get-owner";

export default class searchFilters extends Component {
  @service site;

  @action
  filterSearch(slug) {
    const searchController = getOwner(this).lookup(
      "controller:full-page-search"
    );

    let categoryRegex = new RegExp(/#\S+/, "g");
    let searchTerm = searchController.searchTerm.replace(categoryRegex, "");

    searchTerm = `${searchTerm} #${slug}`;

    searchController.set("searchTerm", searchTerm.replace(/\s\s+/g, " "));

    searchController.send("search");
  }
}
