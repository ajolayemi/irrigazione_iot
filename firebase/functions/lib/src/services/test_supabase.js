"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const read_companies_data_1 = require("../database/companies/read_companies_data");
const secrets_1 = require("./secrets");
(async () => {
    const testCompany = await (0, read_companies_data_1.getCompanyById)("3");
    console.log(testCompany === null || testCompany === void 0 ? void 0 : testCompany.name);
})();
(async () => {
    const url = await (0, secrets_1.getSecretFromCloud)("SUPABASE_URL");
    const anon = await (0, secrets_1.getSecretFromCloud)("SUPABASE_ANON_KEY");
    console.log(url);
    console.log(anon);
})();
//# sourceMappingURL=test_supabase.js.map