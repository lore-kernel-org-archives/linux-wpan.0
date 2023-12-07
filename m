Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="ATAmXDn7"
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432E1719;
	Thu,  7 Dec 2023 12:47:08 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id AE432C0983;
	Thu,  7 Dec 2023 21:47:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701982026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snF+Pxo973dTc4LISRuIFkI72Wog+XZrIAwJLn/0LSU=;
	b=ATAmXDn7NmX6Ngnj1fRa3Z+XtqwEK+BTQ3Tz6pZz6SOxUsI0bPeqGDKwTgXvKh827cfjNI
	1QlCjohVWXbHHLMUv1gM9hWdCqefP29zziCw/CE7HSDSM6Dlj8bGkDsXnWLcN+nxrVPhoj
	X6Bi7uLbGgcnNahzuYU+TLOCgCGr/+ze0ReKmEQL9LQwKLGCRFKOiBuTUcVp3jsOMlrzRd
	skFyRzgrutGFDxLdtc+GsmiVZkm6pzUhpBhMMwt3qI4+srUg+3f9i6wpQVZFVwsNT9dXpd
	Ve2XvNU2n7n+qEOuc81gEnG4ogUQbHxtqxerx+w8PpjA5vhlM9aJFn1xqH9/3A==
Message-ID: <56688a1b-c438-eefa-95a5-3d780a94745a@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next 4/5] ieee802154: Avoid confusing changes after
 associating
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
 <20231128111655.507479-5-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128111655.507479-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:16, Miquel Raynal wrote:
> Once associated with any device, we are part of a PAN (with a specific
> PAN ID), and we are expected to be present on a particular
> channel. Let's avoid confusing other devices by preventing any PAN
> ID/channel change once associated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   net/ieee802154/nl802154.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index e4d290d0e0a0..5c73b5fcadc0 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1087,6 +1087,15 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
>   
>   	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
>   
> +	/* Only allow changing the PAN ID when the device has no more
> +	 * associations ongoing to avoid confusing peers.
> +	 */
> +	if (cfg802154_device_is_associated(wpan_dev)) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Existing associations, changing PAN ID forbidden");
> +		return -EINVAL;
> +	}
> +
>   	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
>   }
>   
> @@ -1113,20 +1122,17 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
>   
>   	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
>   
> -	/* TODO
> -	 * I am not sure about to check here on broadcast short_addr.
> -	 * Broadcast is a valid setting, comment from 802.15.4:
> -	 * A value of 0xfffe indicates that the device has
> -	 * associated but has not been allocated an address. A
> -	 * value of 0xffff indicates that the device does not
> -	 * have a short address.
> -	 *
> -	 * I think we should allow to set these settings but
> -	 * don't allow to allow socket communication with it.
> +	/* The short address only has a meaning when part of a PAN, after a
> +	 * proper association procedure. However, we want to still offer the
> +	 * possibility to create static networks so changing the short address
> +	 * is only allowed when not already associated to other devices with
> +	 * the official handshake.
>   	 */
> -	if (short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC) ||
> -	    short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST))
> +	if (cfg802154_device_is_associated(wpan_dev)) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Existing associations, changing short address forbidden");
>   		return -EINVAL;
> +	}
>   
>   	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
>   }

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
