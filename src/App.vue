<template>
    <v-app>
        <v-toolbar app class="white">
            <v-toolbar-title class="headline">
                <span class="primary--text">LANTERN</span>
                <span class="font-weight-light">CHARTS</span>
            </v-toolbar-title>
            <v-spacer></v-spacer>
        </v-toolbar>

        <v-content justify-center class="white">
            <v-container class="container">
                <router-view></router-view>
            </v-container>
        </v-content>
    </v-app>
</template>

<script>
import HelloWorld from "./components/HelloWorld";

export default {
    name: "App",
    components: {
        HelloWorld
    },
    data() {
        return {
            //
        };
    }
};
</script>
<style lang="less" scoped>
.v-toolbar {
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.container {
    max-width: 1024px;
}
</style>
