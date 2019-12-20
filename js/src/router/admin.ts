import { RouteConfig } from 'vue-router';
import Dashboard from '@/views/Admin/Dashboard.vue';
import Follows from '@/views/Admin/Follows.vue';
import Followings from '@/components/Admin/Followings.vue';
import Followers from '@/components/Admin/Followers.vue';
import Settings from '@/views/Admin/Settings.vue';

export enum AdminRouteName {
  DASHBOARD = 'Dashboard',
  RELAYS = 'Relays',
  ADMIN_SETTINGS = 'ADMIN_SETTINGS',
  RELAY_FOLLOWINGS = 'Followings',
  RELAY_FOLLOWERS = 'Followers',
}

export const adminRoutes: RouteConfig[] = [
  {
    path: '/admin',
    name: AdminRouteName.DASHBOARD,
    component: Dashboard,
    props: true,
    meta: { requiredAuth: true },
  },
  {
    path: '/admin/settings',
    name: AdminRouteName.ADMIN_SETTINGS,
    component: Settings,
    props: true,
    meta: { requiredAuth: true },
  },
  {
    path: '/admin/relays',
    name: AdminRouteName.RELAYS,
    redirect: { name: AdminRouteName.RELAY_FOLLOWINGS },
    component: Follows,
    children: [
      {
        path: 'followings',
        name: AdminRouteName.RELAY_FOLLOWINGS,
        component: Followings,
      },
      {
        path: 'followers',
        name: AdminRouteName.RELAY_FOLLOWERS,
        component: Followers,
      },
    ],
    props: true,
    meta: { requiredAuth: true },
  },
];
