#!/bin/sh

LF=$(printf '\\\012_')
LF=${LF%_}
EXTENSION_NAME=TM2Scratch
EXTENSION_ID=tm2scratch
COLLABORATOR="SeoulInventorsClub"
EXTENSION_DESCRIPTION="티처블머신 AI 활용"

mkdir -p scratch-vm/src/extensions/scratch3_${EXTENSION_ID}
cp ${EXTENSION_ID}/scratch-vm/src/extensions/scratch3_${EXTENSION_ID}/index.js scratch-vm/src/extensions/scratch3_${EXTENSION_ID}/
mv scratch-vm/src/extension-support/extension-manager.js scratch-vm/src/extension-support/extension-manager.js_orig
sed -e "s|class ExtensionManager {$|builtinExtensions['${EXTENSION_ID}'] = () => require('../extensions/scratch3_${EXTENSION_ID}');${LF}${LF}class ExtensionManager {|g" scratch-vm/src/extension-support/extension-manager.js_orig > scratch-vm/src/extension-support/extension-manager.js

mkdir -p scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}
cp ${EXTENSION_ID}/scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/${EXTENSION_ID}.png scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/
cp ${EXTENSION_ID}/scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/${EXTENSION_ID}-small.png scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/
mv scratch-gui/src/lib/libraries/extensions/index.jsx scratch-gui/src/lib/libraries/extensions/index.jsx_orig
mv scratch-gui/src/containers/extension-library.jsx scratch-gui/src/containers/extension-library.jsx_orig
cp ${EXTENSION_ID}/scratch-gui/src/containers/extension-library.jsx scratch-gui/src/containers/extension-library.jsx
DESCRIPTION="\
    {${LF}\
        name: '${EXTENSION_NAME}',${LF}\
        extensionId: '${EXTENSION_ID}',${LF}\
        collaborator: '${COLLABORATOR}',${LF}\
        iconURL: ${EXTENSION_ID}IconURL,${LF}\
        insetIconURL: ${EXTENSION_ID}InsetIconURL,${LF}\
        description: (${LF}\
            <FormattedMessage${LF}\
                defaultMessage='${EXTENSION_DESCRIPTION}'${LF}\
                description='${EXTENSION_DESCRIPTION}'${LF}\
                id='gui.extension.${EXTENSION_ID}blocks.description'${LF}\
            />${LF}\
        ),${LF}\
        featured: true,${LF}\
        disabled: false,${LF}\
        internetConnectionRequired: true,${LF}\
        bluetoothRequired: false,${LF}\
        translationMap: {${LF}\
            'ja': {${LF}\
                'gui.extension.tm2scratchblocks.description': '画像や音声を学習させよう。'${LF}\
            },${LF}\
            'ja-Hira': {${LF}\
                'gui.extension.tm2scratchblocks.description': 'がぞうやおんせいをがくしゅうさせよう。'${LF}\
            },${LF}\
            'en': {${LF}\
                'gui.extension.tm2scratchblocks.description': 'Recognize your own images and sounds.'${LF}\
            },${LF}\
            'zh-cn': {${LF}\
                'gui.extension.tm2scratchblocks.description': 'Recognize your own images and sounds.'${LF}\
            },${LF}\
            'ko': {${LF}\
                'gui.extension.tm2scratchblocks.description': '나의 이미지와 소리를 인식해볼까요'${LF}\
            },${LF}\
            'zh-tw': {${LF}\
                'gui.extension.tm2scratchblocks.description': 'Recognize your own images and sounds.'${LF}\
            }${LF}\
        }${LF}\
    },"
sed -e "s|^export default \[$|import ${EXTENSION_ID}IconURL from './${EXTENSION_ID}/${EXTENSION_ID}.png';${LF}import ${EXTENSION_ID}InsetIconURL from './${EXTENSION_ID}/${EXTENSION_ID}-small.png';${LF}${LF}export default [${LF}${DESCRIPTION}|g" scratch-gui/src/lib/libraries/extensions/index.jsx_orig > scratch-gui/src/lib/libraries/extensions/index.jsx
