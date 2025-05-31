import Component from "@ember/component";
import { classNames } from "@ember-decorators/component";
import CustomCategorySearchFilters from "../../components/custom-category-search-filters";

@classNames(
  "full-page-search-below-search-info-outlet",
  "custom-category-search-filters"
)
export default class CustomCategorySearchFiltersConnector extends Component {
  <template>
    <CustomCategorySearchFilters
      @categories={{this.site.categories}}
      @search={{this.search}}
    />
  </template>
}
