import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { gt } from "truth-helpers";
import { getOwner } from "discourse/lib/get-owner";

export default class SearchFilters extends Component {
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

  <template>
    {{#each this.site.categories as |c|}}
      {{#if (gt c.topic_count 0)}}
        <div
          class="custom-category-search-filter"
          {{! template-lint-disable no-invalid-interactive }}
          {{on "click" (action "filterSearch" c.slug)}}
        >
          {{#if c.uploaded_logo}}
            <img
              class="custom-category-search-filter__image"
              src={{c.uploaded_logo.url}}
            />
          {{/if}}

          <div class="custom-category-search-filter__name">
            {{c.name}}
          </div>

          <div class="custom-category-search-filter__count">
            {{c.topic_count}}
            topics
          </div>
        </div>
      {{/if}}
    {{/each}}
  </template>
}
