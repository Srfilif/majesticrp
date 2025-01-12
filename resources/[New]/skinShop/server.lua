addEvent("takeMoneyForSkin", true)
addEventHandler("takeMoneyForSkin", root,
    function(model, money)
        takePlayerMoney(source, money)
        --
        setElementData(source, "pskin", model);
        setElementModel(source, model)
        outputChatBox("#39ac39[INFO] #e6e6e6Başarılı bir şekilde satın aldınız.!", source, 51, 153, 51, true )
	end
)


-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy