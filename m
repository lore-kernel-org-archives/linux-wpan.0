Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F61309DCE;
	Fri,  4 Jul 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645442; cv=none; b=lM9SeU1a9sMx4UheZmddbYJMTA4SJgsSIlYstwR+2rQNqZZzzxQNVbjGel59BtQmqxcdoP6YTVB6XuFKZ9316/pUTE796iVYZke/o1pZGCS1wuOltV7lwskWggihPsZTnCoTba8yH2+4fLSDWwMX8MDELDBY0t3XICLysHhp5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645442; c=relaxed/simple;
	bh=zde6HvegWQmvNgresB64/ug3JS71JPrGTApPR2NkE/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep3sbiXE2h+s6cVd33OYHZccrmkv2dwl8Iz3z7FBVq71SDlYCCZ8GKp00wIIgRDVSs/OR1VPlIQOG+734xjdK2WzFQ5umjpCHcNXng15Hwzoq06b1AJaTNFl240BDuBtPULCkakiiPFByrJjUPAorrXEjOKXThbTZH1HnbloK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSRtQBSq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSRtQBSq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F61B1400380;
	Fri,  4 Jul 2025 12:10:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Jul 2025 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751645440; x=1751731840; bh=89R2ywVdq4YId9PTX8Syu2nc1CBcPDy/wRG
	poeflJto=; b=bSRtQBSqvZ/yCBLMKs9JNvF+XuW3xiTSLQpVPladobN53QFT6QA
	nMk/x1HfLGJYOE9065AQCNIKzmTOmevZmcjpg0jpwJqlZcGNgzvqLGeOUyKk+EBW
	vPmSPyaJ8F/J7kdRxIHWxlxOL7gkMKgePFDTXxgmjQzRGlA/+N7tnNydwGPnL6n9
	onnC9E6acteBSqGunS3SusCXZFbLxNoaggAc9yqpYqb3q3bibB32F3FIC0ajLg/3
	PYNjKV1N9j0GT4YE6kPanXcB1UtZlmGph9havX3NAQhKpvOvZ7tFYlp7Y2RSkSIJ
	xKKQLPYuhiOTnm+yw0N4fvf8Xp/v6pbuCbA==
X-ME-Sender: <xms:__xnaAE7hDwZ0u9-eQeMtGmKTFkqDrqlrW4INhv2kCjwH0It4GvA1Q>
    <xme:__xnaJUhMhwik_H73ieBv78yRoN9uiXxq2w_FZ9RY2hk_gvSzogL9Qtq-FTtE-L7g
    mW2NX9kr3QC1cM>
X-ME-Received: <xmr:__xnaKKCQC7HNJvKp8iw6PrbLUgjRnyVtPIouIY_8PUhFRk2y111393RDL5m1DBt3PaOjwJ00GFFd9ByZUzEkB9ZAKJZPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepfigrnhhglhhirghnghejgeeshhhurgifvghirdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephihuvghhrghisghinhhgsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:__xnaCGXENXOf1mctvSOHpUaNJtbsTTFlneLjYwJT8OeMVsrlMRTjw>
    <xmx:__xnaGXDh8wBIioG3yLGF5eg-f4rKV2Tmc4_tL26sg4mqzYuTIvSAw>
    <xmx:__xnaFOMXUfN_gcaLJshy_GWFpkuDD1mU8SKlKwvStupbhvPxG9T_w>
    <xmx:__xnaN3iCDiLTs6ZTkvvAWsK3rP4W5BNjs_KAo4CzLRVL4YUd482gQ>
    <xmx:AP1naO4svtiqx9phyOUUPjB8XlOUBwScG8tDDyoNeDo4hZ9hserUIBPb>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 12:10:39 -0400 (EDT)
Date: Fri, 4 Jul 2025 19:10:37 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
	dsahern@kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: replace ND_PRINTK with dynamic debug
Message-ID: <aGf8_dnXpnzCutA7@shredder>
References: <20250701081114.1378895-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701081114.1378895-1-wangliang74@huawei.com>

On Tue, Jul 01, 2025 at 04:11:14PM +0800, Wang Liang wrote:
> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.

One small comment below

[...]

> @@ -751,9 +747,8 @@ static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
>  	probes -= NEIGH_VAR(neigh->parms, UCAST_PROBES);
>  	if (probes < 0) {
>  		if (!(READ_ONCE(neigh->nud_state) & NUD_VALID)) {
> -			ND_PRINTK(1, dbg,
> -				  "%s: trying to ucast probe in NUD_INVALID: %pI6\n",
> -				  __func__, target);
> +			net_warn_ratelimited("%s: trying to ucast probe in NUD_INVALID: %pI6\n",
> +					     __func__, target);

Without getting into a philosophical discussion about the appropriate
log level for this message, the purpose of this patch is to move
ND_PRINTK(val > 1, ...) to net_dbg_ratelimited(), but for some reason
this hunk promotes an existing net_dbg_ratelimited() to
net_warn_ratelimited(). Why not keep it as net_dbg_ratelimited()?

>  		}
>  		ndisc_send_ns(dev, target, target, saddr, 0);
>  	} else if ((probes -= NEIGH_VAR(neigh->parms, APP_PROBES)) < 0) {
