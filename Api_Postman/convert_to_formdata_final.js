const fs = require('fs');

const filePath = 'Trovo_Pro_API.postman_collection.json';
const inputData = JSON.parse(fs.readFileSync(filePath, 'utf8'));

function convertToFormdata(items) {
    items.forEach(item => {
        if (item.item) {
            convertToFormdata(item.item);
        } else if (item.request) {
            
            // Remove Content-Type header if it exists so Postman automatically sets multipart/form-data
            if (item.request.header) {
                item.request.header = item.request.header.filter(h => h.key.toLowerCase() !== 'content-type');
            }

            if (item.request.body) {
                let body = item.request.body;
                
                // Case 1: Body is raw JSON
                if (body.mode === 'raw' && body.raw) {
                    try {
                        const parsed = JSON.parse(body.raw);
                        const formdata = [];
                        for (const [k, v] of Object.entries(parsed)) {
                            // If value is a file placeholder from scribe, change type to file
                            if (typeof v === 'string' && (v.includes('file') || v.includes('.jpg') || v.includes('.png'))) {
                                formdata.push({
                                    key: k,
                                    type: "file",
                                    src: []
                                });
                            } else {
                                formdata.push({
                                    key: k,
                                    value: (typeof v === 'object' && v !== null) ? JSON.stringify(v) : String(v),
                                    type: "text"
                                });
                            }
                        }
                        item.request.body = {
                            mode: "formdata",
                            formdata: formdata
                        };
                    } catch(e) {
                        // Not a valid JSON, leave as is
                    }
                } 
                // Case 2: Body exists but mode might not be formdata
                else if (body.mode !== 'formdata') {
                    item.request.body = {
                        mode: "formdata",
                        formdata: []
                    };
                }
            } else {
                // Case 3: No body at all, initialize empty formdata just in case user wants to add something later
                item.request.body = {
                    mode: "formdata",
                    formdata: []
                };
            }
        }
    });
}

convertToFormdata(inputData.item);

fs.writeFileSync(filePath, JSON.stringify(inputData, null, 4));
console.log("Converted all bodies to formdata successfully.");
