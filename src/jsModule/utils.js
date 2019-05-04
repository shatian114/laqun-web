export function file2txtArr(file) {
    var fr = new FileReader;
    fr.readAsText(file);
    return new Promise((resolve) => {
        fr.onload = function() {
            resolve(this.result.split('\n'));
        }
    });
    
}