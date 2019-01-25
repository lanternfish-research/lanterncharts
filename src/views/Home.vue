<template>
    <div>
        <h1>Demo Charts</h1>
        <CountbyYear/>
        <CountbyYearCompany/>
        <CountbyPatentsYear/>
        <CountbyPatentsCompany/>
        <CountbyPatentsField/>
        <CountbyPatentsPercent/>
        <CountbyCountry/>
    </div>
</template>

<script>
import HelloWorld from "../components/HelloWorld";
import CountbyYear from "../components/CountbyYear";
import CountbyYearCompany from "../components/CountbyYearCompany";
import CountbyCountry from "../components/CountbyCountry";
import CountbyPatentsCompany from "../components/CountbyPatentsCompany";
import CountbyPatentsField from "../components/CountbyPatentsField";
import CountbyPatentsPercent from "../components/CountbyPatentsPercent";
import CountbyPatentsYear from "../components/CountbyPatentsYear";

export default {
    components: {
        CountbyYear,
        CountbyYearCompany,
        CountbyPatentsYear,
        CountbyPatentsCompany,
        CountbyPatentsField,
        CountbyPatentsPercent,
        CountbyCountry,

    }
};
</script>
