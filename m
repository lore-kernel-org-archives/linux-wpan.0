Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="YiFC4s4r"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7DC173C;
	Thu,  7 Dec 2023 12:49:49 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id EAF3BC0290;
	Thu,  7 Dec 2023 21:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701982187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h9SVQ16RMsyU37Ibdhe2UG8oWpn1hzWsqTy4lfeOY8=;
	b=YiFC4s4rwrpVF0iP5z/+1c8+kbQXiWD8smrl52fTNxy1PoOUG3yk5a9qqhfMPDeJ75grdl
	1DaBkQuB5Ddw2nlkRI0spWyC1vNUP3nXi07ACL5kOmrCdkRTfreVbH1WP/3SVBK0aYS8UI
	9CpLCkoP+Rd0e16v+P8p3ulePIPMmnDN35ffC2c5Cu5IUvixUMp7yBz1RLOFbm81KEhlh7
	tZGlL0NGvfsgwzSVziNt243DxUfpQxx1eWNUTicR1nIwGEISNF583tR2i/AKBZbgCW8oPS
	y9OI0HgO4qNS+dTpHBD3GCHU0BidtG0Te6NfvU+1rOypZZOVja4fj1C4aqfv8w==
Message-ID: <b28ae3df-3457-0053-6c6a-71cc8f497f2b@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next 5/5] mac802154: Avoid new associations while
 disassociating
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
 Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>,
 Guilhem Imberton <guilhem.imberton@qorvo.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
References: <20231128111655.507479-1-miquel.raynal@bootlin.com>
 <20231128111655.507479-6-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128111655.507479-6-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:16, Miquel Raynal wrote:
> While disassociating from a PAN ourselves, let's set the maximum number
> of associations temporarily to zero to be sure no new device tries to
> associate with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   include/net/cfg802154.h |  4 +++-
>   net/ieee802154/pan.c    |  8 +++++++-
>   net/mac802154/cfg.c     | 11 ++++++++---
>   3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index a64bbcd71f10..cd95711b12b8 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -589,8 +589,10 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>    * cfg802154_set_max_associations - Limit the number of future associations
>    * @wpan_dev: the wpan device
>    * @max: the maximum number of devices we accept to associate
> + * @return: the old maximum value
>    */
> -void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max);
> +unsigned int cfg802154_set_max_associations(struct wpan_dev *wpan_dev,
> +					    unsigned int max);
>   
>   /**
>    * cfg802154_get_free_short_addr - Get a free address among the known devices
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> index fb5b0af2ef68..249df7364b3e 100644
> --- a/net/ieee802154/pan.c
> +++ b/net/ieee802154/pan.c
> @@ -94,10 +94,16 @@ __le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
>   }
>   EXPORT_SYMBOL_GPL(cfg802154_get_free_short_addr);
>   
> -void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max)
> +unsigned int cfg802154_set_max_associations(struct wpan_dev *wpan_dev,
> +					    unsigned int max)
>   {
> +	unsigned int old_max;
> +
>   	lockdep_assert_held(&wpan_dev->association_lock);
>   
> +	old_max = wpan_dev->max_associations;
>   	wpan_dev->max_associations = max;
> +
> +	return old_max;
>   }
>   EXPORT_SYMBOL_GPL(cfg802154_set_max_associations);
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 17e2032fac24..ef7f23af043f 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -389,6 +389,7 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
>   	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
>   	struct ieee802154_pan_device *child, *tmp;
>   	struct ieee802154_sub_if_data *sdata;
> +	unsigned int max_assoc;
>   	u64 eaddr;
>   	int ret;
>   
> @@ -397,6 +398,7 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
>   	/* Start by disassociating all the children and preventing new ones to
>   	 * attempt associations.
>   	 */
> +	max_assoc = cfg802154_set_max_associations(wpan_dev, 0);
>   	list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
>   		ret = mac802154_send_disassociation_notif(sdata, child,
>   							  IEEE802154_COORD_WISHES_DEVICE_TO_LEAVE);
> @@ -429,14 +431,17 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
>   	if (local->hw.flags & IEEE802154_HW_AFILT) {
>   		ret = drv_set_pan_id(local, wpan_dev->pan_id);
>   		if (ret < 0)
> -			return ret;
> +			goto reset_mac_assoc;
>   
>   		ret = drv_set_short_addr(local, wpan_dev->short_addr);
>   		if (ret < 0)
> -			return ret;
> +			goto reset_mac_assoc;
>   	}
>   
> -	return 0;
> +reset_mac_assoc:
> +	cfg802154_set_max_associations(wpan_dev, max_assoc);
> +
> +	return ret;
>   }
>   
>   static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
