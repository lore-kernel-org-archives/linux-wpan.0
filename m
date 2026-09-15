Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BF3911D5;
	Tue, 15 Sep 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449989; cv=none; b=QH7VgbtvaZQ+h7pdjzh5iDfLuPiM1NZBr7KpNqLgzHRWSDwtFEus4HbwWDcStZvLANCwQ/UiFdhrfqEIdyHOPeDWZd9tSdKrFHFEC6T3sP6FbmXuLnGZA50UCj6hQ2jPwTagoPWbS0Iqesa98T9OfLSvGPTuQiqKpDX63C5+cC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449989; c=relaxed/simple;
	bh=aP00zB2vwTB3f8YJgoYb84OWuA0nhfnOSanrcoTEzV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJs9KetVL2cUFOQsO6wM8y/BpdSXjT23YHae8G1QLNcQs0mGFVnq0ig0K16U4jhAKsC66/ilB2AibZhAxEtrRLYhwpeAECe5ZuE1nCkmKaW6gUsDbCDuLvc8J26NmJRZfU48tq5mbsc9jSuhfaZ1omCGfY09UZO0WsemLeYs/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ILyBTldE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILyBTldE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1c5mzcm+uSJH/DtWgavu8DM7f9DCOGPDOW8edkuJv3o=; b=ILyBTldE/3fvwiQvczW6GZNgXS
	T3LpZ3NJGXxj9F1An1TrTZNKWD0lZHNsV2AuTJHxoHWCr8hJFr5afzFrt5Q9u1DCdI+qOJluLTwZE
	xy9tuNnAIOyn5froN9s3iY9wERMiqCqEAcBQUTB7vLYgg2ZN4OGtL350VDB4L8PDcVSS353p/5QQR
	jA6dm8HYS7F2MdOi10Z4tQ07ncPMurEjuLtEHWfVGzgr8b5+FW/3J0BF9Jyb7+8+LNCwi9Da2it8Z
	wHgWYtLk99tcWxDFOxA1hz2Xne3Vma+lulgZEDrDTtqcFG71mC00yhCN/EzDzUjWWZDyHe9pSD4ZT
	WRt2K5Og==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6LgU-00000005F2l-3sGI;
	Tue, 15 Sep 2026 05:26:22 +0000
Message-ID: <4169629e-74c1-4a21-a187-6c65d70502fa@infradead.org>
Date: Mon, 14 Sep 2026 22:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] ipv6: update NUD_FAILED neighbors from NA
 messages
To: Lawrence Lee <lfqlee314@gmail.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Arun Ajith S <aajith@arista.com>, Roopa Prabhu <roopa@nvidia.com>,
 Jaehee Park <jhpark1013@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
 linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <cover.1789448374.git.lfqlee314@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cover.1789448374.git.lfqlee314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/26 10:01 PM, Lawrence Lee wrote:
> Testing:
> - x86_64 current-config and allyesconfig builds with W=1

What does current-config mean?

> - tools/testing/selftests/net/ndisc_unsolicited_na_test.sh: 14 passed
> - Local NIPA checks: all substantive checks passed
> - Sashiko local review completed

thanks.
-- 
~Randy

