exports.handler = async (_event, context, callback) => {
    const sharedmem = context.sharedmem;
    const healtherror = sharedmem.getString("healtherror")

    if ( healtherror ){
        callback(null, {
            status: 500,
            content: healtherror
        });
        return;
    }

    callback(null, {
        status: 200,
        content: "OK"
    });
};
