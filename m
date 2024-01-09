Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C4944D
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="tQVO3lus"
Received: from [192.168.2.51] (p4fe71516.dip0.t-ipconnect.de [79.231.21.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id D5755C0280;
	Tue,  9 Jan 2024 08:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1704785687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5vjctOpKQH94S9CTIjDoPt6i5gmLtZQHEWT9bmH9IY=;
	b=tQVO3lusxrVZA7nuBDQbztGWxIOuatMPpVVdwqNjCMR8tK8joeCVoZWjMS6O8RitPD6BVa
	1Qr4p5Vz8PYn8w8V3avzxSTu6IS1Jsyyv6pi/cyUJfYVSCqST0dcL3BqeTzdoUDT1yGOBv
	93mt8DLb6DwpQb/MeNDS9M3nMwr6khQXkm7ifYqFLKcv/dqKhmg2jruWGiOtuKKfKcuhhu
	jyvF0Hhmu59xnxdGrebu1arXfUHFoBXIesZLhwBIac4/1GbdOGhUf+khjjdnF55CSZINAd
	0w28eBZlRISLAy8LixSp+ZWipg0qBgN0FCAKfDcOh3FQlN6G2aggwSrC9bMbfA==
Message-ID: <4f4ae371-9993-4964-a61e-a88d885e1161@datenfreihafen.org>
Date: Tue, 9 Jan 2024 08:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux WPAN and Contiki NG
Content-Language: en-US
To: =?UTF-8?Q?Marek_K=C3=BCthe?= <m-k-mailling-list@mk16.de>,
 linux-wpan@vger.kernel.org
References: <20240108170928.2b1d0fd9@ciel>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240108170928.2b1d0fd9@ciel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Marek,

On 08.01.24 18:09, Marek Küthe wrote:
> Hello dear Mailling list,
> 
> I would like to try Linux WPAN with Contriki NG and have some questions
> (I am new to the topic, so the questions may be quite stupid): Contiki
> NG, as I understand it, implements various 6lowpan standards -
> including 6TiSCH, TSCH and 6TOP. Which of these are also implemented in
> Linux WPAN and how can they be used? As I understand it, TSCH is
> implemented. Is that correct?

I fear none of these advanced mechanisms (mostly for packet scheduling) 
are implemented. Linux wpan offers the basics in 802.15.4 and 6lowpan. 
PHY and MAC access and encapsulations and compression with 6lowpan.

  The use of it is explained on
> https://linux-wpan.org/documentation.html.
> Is there anything special I need to consider when connecting Linux and
> Contiki NG?

I have not looked at Contiki in years to be fair. In general the main 
1.4 and 6lowpan communication should work. If you enable advanced 
techniques for packet scheduling and timing you will surely run into 
problems. Would be happy to hear findings when you tried it. :-)

> I hope it's okay if I post my questions here on the Mailling list.

Its the perfect place for them. :-)

regards
Stefan Schmidt
