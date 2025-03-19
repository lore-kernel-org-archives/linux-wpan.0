Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A981E32B9
	for <linux-wpan@vger.kernel.org>; Wed, 19 Mar 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403224; cv=none; b=OVkkw5yP5Zij1iH7ssp9ewpQAv2/QbGuSxuhZPvoy+zL5kiciZ5Gh1AOonm18E2AhZSGOtLhpnLJjZi4Duia0lUEmhmMTD4JlL7fJB8rZFcrop1JezcZh50Vb85EuADJYp97PQAD1RkgPjzH2ewVGZkCmBYEF6RSHnLfeUf/P+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403224; c=relaxed/simple;
	bh=oz+OFIGWSJQCLzloFMS5sii2D0iTDhSONOD8RtUSsOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU991Xq1U3V3GN+kLvsKWIyVvIf1yO1W7tr5p7NZgc8LTsUQQgG8n0dxVfrr08bUjT2/UJfOldH9joJfxZtnWUqr8nehDscv7I3IUGE8NJP37coX/ViUF7kPwafWYXt+2zrqbqOnufTTrIJWCLHNtkryChfQb30X30pL66f+Biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf5BegEu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf5BegEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742403220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lh4LVotVsrWlMGgk1KmT3ER5dUQjkNY6mvUaXMFckIg=;
	b=Jf5BegEuKx5Pq3xt7Lb4E/wT23GfaD/ZcrU//Owp5FcsAf1SptkGW38Zj2mkJ2aNR39YwA
	eNVYxrr4/wLLscJ0rGLqDRuPJQCFBafIBkgs6yddVMIcq6UX7KQAo1FJnsVYabvCenusLq
	BMyzWvv1JN/I9rrQOfOr9LxmdnH6LME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-SMiDVzdUPaqoeMRuERjK0w-1; Wed, 19 Mar 2025 12:53:38 -0400
X-MC-Unique: SMiDVzdUPaqoeMRuERjK0w-1
X-Mimecast-MFC-AGG-ID: SMiDVzdUPaqoeMRuERjK0w_1742403218
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so34293955e9.1
        for <linux-wpan@vger.kernel.org>; Wed, 19 Mar 2025 09:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403218; x=1743008018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh4LVotVsrWlMGgk1KmT3ER5dUQjkNY6mvUaXMFckIg=;
        b=AM1Ce+5rq5EnBl/LLoOUtHZ0HucGFDwCNeuHgxJn/R7lda9RKuXXzzdmf5V8I6t9D/
         f5aBRjDWcq9vyJgEb8eRLZixfACBWcfLPbKJuR72g/DWFZlINn3hZPMfwrBh6w13e19j
         8+X7dS4m2ZW9VDpt0b/mLJVF1BYzUOOmwTdP9Ri4Adrz6uUB2ctNYi26IoNJ2kUvDCV1
         q3OyKplx17lfTJnT4vOeI0+Cz5THTLVUhRVP/iSmA1eSR+CBqhRC3dwnfPdBGsPL30Vx
         hupgXXxN/OKz4Rhq2HRFoH+PHZAZ2he2mQ2n0+YdOL/fRmrsujqwgsXgBxZuz803vWZV
         PLCw==
X-Gm-Message-State: AOJu0Yx3ZFiCNbwy54NU3GDIVujA0+n45XjSkqDofYwXonehyqKuvrlS
	m6vQiBPxSwIqJpLOkTiL78E0JXar2HRjCoTzaXc+iN9pVyosmAFnsf75GEsetTDYhobGhSeJ3Eq
	sHufRRVhCIqMEbW5rFlxkVrx2jEp39Gmk4yG+HGDq1FVHTJdYZl5x5ESVl5Q=
X-Gm-Gg: ASbGnctGo5rRP1hzXTqQT7+QEucouwElG482R+94Xo4YUlQmxlMX/OCmrGHHprCf63b
	jivVseSp/K4vp9cqvq2JZum+oYxpwcB/fUPf7U6Ow6hIvnjxins46av8iQtk6rEqGmVUvuHTH3A
	rv3GYJVrTnHHybw6HQFZJsah1qvGYN91mBwMhJQu264YVGIxqb2xRd2fTBKscRY/rZSCck2Cvcp
	6EWShoWTwfb00H3ZoCISMs4fQCB0ieBFd0KeKBZZtRq9GLeAu3iKEJdozLXdYpyEbN0IZcRiuhk
	biUQ4zMcek7BUUOBUdH/RTc77o/lnIiXMhJbXpsdw1/q9A==
X-Received: by 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr758723f8f.31.1742403217594;
        Wed, 19 Mar 2025 09:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLUmDOWNSsSJgvpfazJk+QouBdD3+MAKJs0286Fi6yxL3Et+VD4N/CZt1FsN80KWfRnOy+TQ==
X-Received: by 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr758680f8f.31.1742403217067;
        Wed, 19 Mar 2025 09:53:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm20989176f8f.85.2025.03.19.09.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:53:36 -0700 (PDT)
Message-ID: <ae626131-20e6-4d7b-b5ec-5a9804917e51@redhat.com>
Date: Wed, 19 Mar 2025 17:53:35 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154-next 2025-03-10
To: Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20250310185752.2683890-1-stefan@datenfreihafen.org>
 <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 7:37 AM, Stefan Schmidt wrote:
> On 10.03.25 19:57, Stefan Schmidt wrote:
>> Hello Dave, Jakub, Paolo.
>>
>> An update from ieee802154 for your *net-next* tree:
>>
>> Andy Shevchenko reworked the ca8210 driver to use the gpiod API and fixed
>> a few problems of the driver along the way.
>>
>> regards
>> Stefan Schmidt
>>
>> The following changes since commit f130a0cc1b4ff1ef28a307428d40436032e2b66e:
>>
>>    inet: fix lwtunnel_valid_encap_type() lock imbalance (2025-03-05 19:16:56 -0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-03-10
>>
>> for you to fetch changes up to a5d4d993fac4925410991eac3b427ea6b86e4872:
>>
>>    dt-bindings: ieee802154: ca8210: Update polarity of the reset pin (2025-03-06 21:55:18 +0100)
>>
>> ----------------------------------------------------------------
>> Andy Shevchenko (4):
>>        ieee802154: ca8210: Use proper setters and getters for bitwise types
>>        ieee802154: ca8210: Get platform data via dev_get_platdata()
>>        ieee802154: ca8210: Switch to using gpiod API
>>        dt-bindings: ieee802154: ca8210: Update polarity of the reset pin
>>
>>   .../devicetree/bindings/net/ieee802154/ca8210.txt  |  2 +-
>>   drivers/gpio/gpiolib-of.c                          |  9 +++
>>   drivers/net/ieee802154/ca8210.c                    | 78 +++++++++-------------
>>   3 files changed, 41 insertions(+), 48 deletions(-)
>>
> 
> Friendly reminder on this pull request. If anything blocks you from 
> pulling this, please let me know.

I'm just lagging behind the PW backlog quite a bit. The PR should be
merged soon.

Thanks for your patience,

Paolo

