"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_data_1 = require("../database/read_data");
const secrets_1 = require("./secrets");
(async () => {
    const testCompany = await (0, read_data_1.getCompanyById)("1");
    console.log(testCompany);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map