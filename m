Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="i5zRPprh"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6261716;
	Thu,  7 Dec 2023 12:42:35 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E6124C0290;
	Thu,  7 Dec 2023 21:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701981754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxK8lzpQ5iQU0+QU1mxReWB1lFD2G7kJg1wd4z7RWQA=;
	b=i5zRPprhu/hAasZsW1n0QqaSEoYWKX0b4Ok27qZXaM4x+uumo/AZJ7C9vLD70puvJk75Ix
	OjbNWXJdjBtGZCQv20+j5bobvdj6fmKq/HZbdAfN0w53iWjs6PWVTpS4O4fIF89XeBFDaw
	EAPZ6jEvZbYVIW3LbzZ90yZcmskbn/Il5fhUfSM2KDPyczOkR5hO687M3cBdpOeb3BvMM3
	A4/g38+nGLyqnPNKoeKMIMZrizqeU3yTxoWSLLs0QMk6SMTjCPZTqMDixevW3IPLBVdsxj
	/cDHKDWRMwlL07rtyT0c895WKeYJD2VXM29353UB154U9x3EFnuJqr9F+i4tUw==
Message-ID: <c8a77faa-6424-a24c-6257-2dc02fe9180b@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next 1/5] mac80254: Provide real PAN coordinator info
 in beacons
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
 <20231128111655.507479-2-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128111655.507479-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:16, Miquel Raynal wrote:
> Sending a beacon is a way to advertise a PAN, but also ourselves as
> coordinator in the PAN. There is only one PAN coordinator in a PAN, this
> is the device without parent (not associated itself to an "upper"
> coordinator). Instead of blindly saying that we are the PAN coordinator,
> let's actually use our internal information to fill this field.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   net/mac802154/scan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index 7597072aed57..5873da634fb4 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -466,6 +466,7 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
>   				  struct cfg802154_beacon_request *request)
>   {
>   	struct ieee802154_local *local = sdata->local;
> +	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
>   
>   	ASSERT_RTNL();
>   
> @@ -495,8 +496,7 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
>   		local->beacon.mac_pl.superframe_order = request->interval;
>   	local->beacon.mac_pl.final_cap_slot = 0xf;
>   	local->beacon.mac_pl.battery_life_ext = 0;
> -	/* TODO: Fill this field with the coordinator situation in the network */
> -	local->beacon.mac_pl.pan_coordinator = 1;
> +	local->beacon.mac_pl.pan_coordinator = !wpan_dev->parent;
>   	local->beacon.mac_pl.assoc_permit = 1;
>   
>   	if (request->interval == IEEE802154_ACTIVE_SCAN_DURATION)

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
