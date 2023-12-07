Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="lMzPMQFk"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62111713;
	Thu,  7 Dec 2023 12:44:15 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id BE172C084A;
	Thu,  7 Dec 2023 21:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701981854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIdjMP8wRQD6/wreL0UGnLohSZxwaG9UFeY3FlDyYU0=;
	b=lMzPMQFkVYIGta1vmb5fF9C1EAGE+gAwD+8V2pquAOos0MpCTCYZgz8wacinFMyCxMZWnA
	6iFbaCyluS7byMjlY9izDGyLvdspGyKfMCP7FHBZjHGR7S5XQ+dDFWn/9MWPkHolKo4PQb
	7ZdDvvCyL0GJ7zlGWcVvzVS2wiepWeiiI8vJuHzVI76mMK7Xlhx4DM8ZJlKleRn+qMe4q+
	Tfits/tfYxpgRGZOUUi+Zh+ShEmWz7bbssIyXYnpNCkv58m+l4zGh9gS6tLm7JtnO6+CsB
	bWO6GFsepiG7fm1XbGeGxoFE/6JmhGZF/res5GzLtUlCLKmzA6WI27phYfRkDA==
Message-ID: <995c0c97-886f-fe8b-b91c-6439a32c8906@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator
 parameter when stamping packets
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
 <20231128111655.507479-3-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128111655.507479-3-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:16, Miquel Raynal wrote:
> ACKs come with the source and destination address empty, this has been
> clarified already. But there is something else: if the destination
> address is empty but the source address is valid, it may be a way to
> reach the PAN coordinator. Either the device receiving this frame is the
> PAN coordinator itself and should process what it just received
> (PACKET_HOST) or it is not and may, if supported, relay the packet as it
> is targeted to another device in the network.
> 
> Right now we do not support relaying so the packet should be dropped in
> the first place, but the stamping looks more accurate this way.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   net/mac802154/rx.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 0024341ef9c5..e40a988d6c80 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -156,12 +156,15 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
>   
>   	switch (mac_cb(skb)->dest.mode) {
>   	case IEEE802154_ADDR_NONE:
> -		if (hdr->source.mode != IEEE802154_ADDR_NONE)
> -			/* FIXME: check if we are PAN coordinator */
> -			skb->pkt_type = PACKET_OTHERHOST;
> -		else
> +		if (hdr->source.mode == IEEE802154_ADDR_NONE)
>   			/* ACK comes with both addresses empty */
>   			skb->pkt_type = PACKET_HOST;
> +		else if (!wpan_dev->parent)
> +			/* No dest means PAN coordinator is the recipient */
> +			skb->pkt_type = PACKET_HOST;
> +		else
> +			/* We are not the PAN coordinator, just relaying */
> +			skb->pkt_type = PACKET_OTHERHOST;
>   		break;
>   	case IEEE802154_ADDR_LONG:
>   		if (mac_cb(skb)->dest.pan_id != span &&

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
