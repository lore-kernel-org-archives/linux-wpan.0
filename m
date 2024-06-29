Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317F2E851;
	Sat, 29 Jun 2024 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719650043; cv=none; b=NIomFAEBtHvkH8UXB3tb7Ito00lOwLctIBg7WDrUmNffbXcuTMGjw6injZuzxg+7kacBbg9JcRmyMXB9lIz0kEKvAX2ysDPY18xnqUj1YORvb2p0K7OfvWb7cMvO6emPW4R2lPrTkxau0/+eWYFlw5ykDQhkDhNbpTKLySBlu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719650043; c=relaxed/simple;
	bh=7hsvc/4AF4K+poGqaHxPF6uEZQ3fI249VTpkx+XaJdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/CxbEywzWR2spWbOe6oT1+Bi6PRigiaxryBJBxLF3kLMw0hQQXPet5Q4RQ6GZAp+qxSlKPQuUSPkdos63FL/mA8jXWNs52JZqb4CmrOxe4juy1xoZz717oUS4FtQgDqJED3K26eZbnnjj6zHTBW/i4N/FO6uRw7eOxtEpCprOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=Bc07rTsu; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="Bc07rTsu"
Received: from [192.168.2.51] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id BF5B9C013E;
	Sat, 29 Jun 2024 10:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1719650029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L41DQp7jtaAXGOr99BfdMVCZM6//4CgcFqUoogApiUg=;
	b=Bc07rTsuBc/j44EWgIgov2AsEsvPi4Ra4SaeP75I0rsW5oVVsbYyPd1QB6JljUaWhBZwlk
	DgfPqTpwJ6GC4Qqx8H8ZrRk3G9HRW4t/504YlJ8Axmj0FQqyFh9/AlrSNoAqIjwkUWJOUE
	aBP5OfUhIizVFUq6unBQlb7/rZo0l8wOG5Bl3js/D6Hf12GHtOKW5Sd3BbwTSZX8yeYNUQ
	PKQ/SwuAnad39lGhVo9ASskowHR/rdDdG8nHt7MCmJWYLTbPETHs6FQVTGRMJ7XAia7Dmh
	o2SelNnptpQ2mo9Km8/zOoVUcGt0zeK1cOgPRGmA+lxG/w/lgygTSQcHDlDWXw==
Message-ID: <e85d1aac-c4e5-4141-b982-da4fdd9fa9e6@datenfreihafen.org>
Date: Sat, 29 Jun 2024 10:33:49 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154 for net 2024-06-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20240627181912.2359683-1-stefan@datenfreihafen.org>
 <20240628183904.4717d073@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240628183904.4717d073@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 29.06.24 03:39, Jakub Kicinski wrote:
> On Thu, 27 Jun 2024 20:19:12 +0200 Stefan Schmidt wrote:
>> Dmitry Antipov corrected the time calculations for the lifs and sifs
>> periods in mac802154.
>>
>> Yunshui Jiang introduced the safer use of DEV_STATS_* macros for
>> atomic updates. A good addition, even if not strictly necessary in
>> our code.
> 
> FTR looks like this got merged by DaveM, thank you!

Thanks for letting me know.

regards
Stefan Schmidt
