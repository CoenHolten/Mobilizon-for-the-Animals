<template>
  <o-taginput
    v-model="modelValue"
    :data="availableActors"
    :allow-autocomplete="true"
    :allow-new="false"
    :open-on-focus="false"
    field="displayName"
    :placeholder="t('Add a recipient')"
    @input="getActors"
  >
    <template #default="props">
      <ActorInline :actor="props.option" />
    </template>
  </o-taginput>
</template>

<script setup lang="ts">
import { SEARCH_PERSON_AND_GROUPS } from "@/graphql/search";
import { IActor, IGroup, IPerson, displayName } from "@/types/actor";
import { Paginate } from "@/types/paginate";
import { useLazyQuery } from "@vue/apollo-composable";
import { ref } from "vue";
import ActorInline from "./ActorInline.vue";
import { useI18n } from "vue-i18n";


type ActorWithName = IActor & { displayName?: String }
const modelValue = defineModel<ActorWithName[]>({
  default: [],
  get(value) {
    return value.map((actor) => ({
      ...actor,
      displayName: displayName(actor),
    }))
  }
})

const { t } = useI18n({ useScope: "global" });

const {
  load: loadSearchPersonsAndGroupsQuery,
  refetch: refetchSearchPersonsAndGroupsQuery,
} = useLazyQuery<
  { searchPersons: Paginate<IPerson>; searchGroups: Paginate<IGroup> },
  { searchText: string }
>(SEARCH_PERSON_AND_GROUPS);

const availableActors = ref<IActor[]>([]);

const getActors = async (text: string) => {
  availableActors.value = await fetchActors(text);
};

const fetchActors = async (text: string): Promise<IActor[]> => {
  if (text === "") return [];
  try {
    const res =
      (await loadSearchPersonsAndGroupsQuery(SEARCH_PERSON_AND_GROUPS, {
        searchText: text,
      })) ||
      (
        await refetchSearchPersonsAndGroupsQuery({
          searchText: text,
        })
      )?.data;
    if (!res) return [];
    return [
      ...res.searchPersons.elements.map((person) => ({
        ...person,
        displayName: displayName(person),
      })),
      ...res.searchGroups.elements.map((group) => ({
        ...group,
        displayName: displayName(group),
      })),
    ];
  } catch (e) {
    console.error(e);
    return [];
  }
};
</script>
