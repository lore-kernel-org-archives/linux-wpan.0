Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="C+4AOUfj"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01E1713;
	Thu,  7 Dec 2023 12:45:23 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 6A096C0983;
	Thu,  7 Dec 2023 21:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701981922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKu6uY5vLBIHkaKUHGEhxsGlS8nfKsTBBhjSQHFfj/8=;
	b=C+4AOUfjxleP61KqVTbrUzDtFQnhC3XZ6Tim1J8cbgMtU6l3NXdYrcbVosAc7BPvb13yQ7
	w2R3KvkYMcL+zacNjvY1pKP5ILy0HJVKSQ3QWsx+dfZRXBLaxXj+WBKdN57RTKCr2tsAIT
	JugzC9Cj8lAGZFlbX2nqEJw7RChkMLqeEYn1B4C0OHFEl19r92o+jolAo+fq+hPCNrzqnl
	O8v1prG0p8h7+3p1+YgPXFBYHxTE2kTNPLKoPn/hBmrwsxHGp9gUUdXBvM/FvmPWo1XMp6
	F2pv7A3beWuYA/TPcv55IYmrZ9Oe9bTvLyl3J4i+LaRHC79+tTQc9FSEE1Bq1A==
Message-ID: <75cd5a2b-38df-27dc-fcaa-418b50bd2f03@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next 3/5] mac802154: Only allow PAN controllers to
 process association requests
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
 <20231128111655.507479-4-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128111655.507479-4-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:16, Miquel Raynal wrote:
> It is not very clear in the specification whether simple coordinators
> are allowed or not to answer to association requests themselves. As
> there is no synchronization mechanism, it is probably best to rely on
> the relay feature of these coordinators and avoid processing them in
> this case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   net/mac802154/scan.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index 5873da634fb4..1c0eeaa76560 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -781,6 +781,12 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
>   		 unlikely(dest->short_addr != wpan_dev->short_addr))
>   		return -ENODEV;
>   
> +	if (wpan_dev->parent) {
> +		dev_dbg(&sdata->dev->dev,
> +			"Ignoring ASSOC REQ, not the PAN coordinator\n");
> +		return -ENODEV;
> +	}
> +
>   	mutex_lock(&wpan_dev->association_lock);
>   
>   	memcpy(&assoc_req_pl, skb->data, sizeof(assoc_req_pl));

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
