Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3C4CDE5
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jan 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="g+A0TDqV"
Received: from [192.168.2.51] (p4fc2fde0.dip0.t-ipconnect.de [79.194.253.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id CDDB9C0A55;
	Wed, 10 Jan 2024 17:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1704903808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UACgsXLxICmWMPGPrPLaIVlsGEnyK6+SzNi9HeeSSn0=;
	b=g+A0TDqVCyr5eDrQGv9MOfYtKkUeqfvMN2sL75EAWROVnKTr7ayIw7ZFdgcjqmgSTnFztk
	P7nK5192qHnOf8u9E4DYC2O/l5lGa3SHksI7VAo6yclhteVBhYYvxdxFVZojXkfgvtC2Jc
	hEfSOBUOzjXbI2nz/LMaVjQujUwse+JLmZ+Hlo8iNrRMD7pMNwN5ahQ7HWlg4A7MqD7WrO
	d+wiuRe4pOZkUEfb2hGD7b4i7A1MdRdN81xnb60E3I1sMcoabGPfp+mYGi5xfhvniLUK2H
	NmNM5UufzHWtWzG8m14tpPPEZkfZxuNE6lv9L2Lqp/8Rsuq5CbZeNmVZdiCW5A==
Message-ID: <75132f84-091b-4814-a080-82aeb47550da@datenfreihafen.org>
Date: Wed, 10 Jan 2024 17:23:28 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux WPAN and Contiki NG
Content-Language: en-US
To: =?UTF-8?Q?Marek_K=C3=BCthe?= <m-k-mailling-list@mk16.de>
References: <20240108170928.2b1d0fd9@ciel>
 <4f4ae371-9993-4964-a61e-a88d885e1161@datenfreihafen.org>
 <20240109183245.0b8b2352@ciel>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
In-Reply-To: <20240109183245.0b8b2352@ciel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Marek,

[I added the list back into cc as I think is could be of interest to 
more people. Also your blog post for people interested in trying out 
Contiki NG with Linux]

On 09.01.24 19:32, Marek Küthe wrote:
> On Tue, 9 Jan 2024 08:34:47 +0100
> Stefan Schmidt <stefan@datenfreihafen.org> wrote:
> 
>> Would be happy to hear findings when you tried it. :-)
> 
> I have written a small blog entry about my configuration. It may not be
> particularly beautiful (written) - but I think you can understand it.
> 
> TLDR: Linux and Contriki NG only work together when Contriki NG is in
> CSMA mode.
> 
> English: https://mk16.de/blog/contiki-ng-linux-wpan-6lowpan-en/
> German: https://mk16.de/blog/contiki-ng-linux-wpan-6lowpan-de/

Thanks, it was a good read.

To address some of your implicit questions in the post. Yes, the first 
missing pings could be due to ND. To be sure you would need to check out 
the packets with wireshark or similar.

As for the MAC access mode needed to be CSMA, yes this is the only one 
supported. The biggest problem, for Linux, with other modes like 6Tisch 
is the hard timing requirements. If it is possible to work in these 
real-time requirements would have to be tested. Nobody stepped up to do 
the implementation yet to try it out.

One could start with simple implementation, if that fails, make use of 
preempt-rt features, if that fails see what hardware timers or other 
capabilities of the transceivers could be used. On the ATUSB, time 
critical pathes could also be offloaded into the firmware.

It all depends on interest, motivation and time :-)

regards
Stefan Schmidt
