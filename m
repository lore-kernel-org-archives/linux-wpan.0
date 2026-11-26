Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722033;
	b=wjo0fds9MfO7Kef16VBGJUK7R6F02Ag1iYmCSVkuCfmUaGSg+A7C0psm3gS+ABlrD495
	 TWvgJ1ITkRLCVn9Q8YOcK5r7fHeOqk8xQAztff7kXpKVOZY95AN6pNshosXKwN1tX58lm
	 FSNsYfqx9SNBN/C8WUUjeet5uNf/wgvQR2/5YXrJtcyEFsTRorXD0Aa/Pm+6FOd6ul3ss
	 PrXnYhmPzqnYuKu6MIwuQ9t7hFvo4KF8SyqPfTQ6huE9eqRK7VO+ASmNXz6Qr6rnybixd
	 gQyUsqVOOBEOg2CIJJgVRTfAkMGtM4WKOH13CFjSYHnu0aKE4XvD7+g0m7WH01E2EBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722033;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=i1JALepU7GR/x3bHR/X22ZryxO1IhoAlF/ZwBjVERkc=;
	b=I7NUxg2molD2fZCjoOAr3LGQMZD0sXZonMQLShfzi7ChDf0aNQCktZXVyjFTXy30mW6Z
	 8iQDEhmM/pGgxqnIvUdROdistizKOlwRJzvuLlSys0MNt/GnDD7rDKLWtg1Jz0inNF5hp
	 edIne9wDpvBO6MYX0Ysipv99N9SLNyMOUjTwSrkRZCUAwGGxJcDvbZt6NE+13YGx0Z1G1
	 UN+dtFbVQbffQG7BUj0zEhZEZkcPeW29D6ogSFEoLLlmCtU1YZpK6IqV5WZZm0nh/mKC1
	 aotFm38HS9IbwcGBxZeohxNPBc1WrOBJFvxfd9st9bnkKJ7ukezNGLQ1RPVF96X//vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GcuCihy0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="gOkql4h/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D476606A326
	for <linux-wpan@vger.kernel.org>; Thu, 26 Nov 2026 19:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D476606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GcuCihy0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gOkql4h/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795722031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1JALepU7GR/x3bHR/X22ZryxO1IhoAlF/ZwBjVERkc=;
	b=GcuCihy09c+faZvz3S/IKGLXI27k43WZJCkFhf+VjUX2LS1hVZpfYXErhA1fuMNf4kGzDZ
	+qH1zDoCW+XqRm72Jto2x4xPstm7BrDEnNXdyDSu8zgqtO/MLOwrKqBXqdlOUsqJLzx3p5
	UIJ+1Chfj5+bwXpScOXU4XkzUqRwv+U=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-_fd94REcNROBHZvWaLmADQ-1; Thu, 26 Nov 2026 19:40:28 +0000
X-MC-Unique: _fd94REcNROBHZvWaLmADQ-1
X-Mimecast-MFC-AGG-ID: _fd94REcNROBHZvWaLmADQ_1795722028
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so5133497eec.1
        for <linux-wpan@vger.kernel.org>; Thu, 26 Nov 2026 11:40:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795722028; cv=none;
        d=google.com; s=arc-20260327;
        b=sg5gMFvMajv+LyqL4re9aPKat4oFE+x/DeTAM0qk8wB6ODqXxWEFdfwvpPLOnZQQXk
         BLIC65kMZX5psHg4MzM8mv89G3qkCux25VX2gg0zGIAmNzAdkGovgexylryQsv2UBSul
         bWfszYmJDse8w9r6JlDR9r20+OnnR2JPeVuTSCZTPyp/+wu4yK6YUKpeY0PLRaxhZR5Z
         OCZCcHkealxRZzDFScmfwZBMcEwKOMVpm2It0b9TQXjnJEUFJvJWrxt4UMocOt2WOdr8
         lEIMw6l1ZyRQkln0l0vW8PdkOVOXg3z6qewACdMM02vaXI/OfGH5MR9rIQVavu/FwnFq
         o+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1JALepU7GR/x3bHR/X22ZryxO1IhoAlF/ZwBjVERkc=;
        fh=5wUuv7Y9hKwcAicSVcmcQp464c4ML/iKKs1hyQM4RPg=;
        b=kctpq+u0sfBDEBMz7NvBHP+XFZbB7kLIx3vfgZ3gxxVfTNlybd1Nn30v5oCp1jEsJb
         A4oCfkY5TsyP2wOfhYpnMfltr4WcB2FCU2PHh1Pe/upqoWhjvvr1+DGG8bE36cpfYr91
         gL97QAZ21ASbBK3D4r4oGaUHIyK/IRYmUWHmBgDaDuUlEi1glCWrcqORsNoNw7/GL00L
         XLQE/bbAxZcYqxwEPdtJ6TRfL+F9nQgrrq7qvJdeXLJegZW2Sa4aRB8PLm0+P2lxou2+
         Qc7XWX+FG1fU5SApmC4qVXRydKam7ym0XiYQR4E1Y18EbwhX3vuB/qVyy8Dsyd7fMhXe
         zaNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795722028; x=1796326828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i1JALepU7GR/x3bHR/X22ZryxO1IhoAlF/ZwBjVERkc=;
        b=gOkql4h/Mdmdaf9ZKrDZtT0Kd//Tb20W7FJNUoig5fnab2TcBgwMknFEX1uBpozlsY
         8ORSoBbvVSDcedOCVzbHpZWORybezRnREo10VBkrZpCOvFTyAhWWVJpP/fpCZ4v1Xbt5
         TfiG3mVp6Hv0FBoqK8PfYmif7Yq1LhldpA6g6O7WovDllIoj9DkZpQ59lLTD2T9qCTeh
         BCjc5DqBvcdboKxIicPoB6okcSh6IN8rCItHtQmUMPTS1rPZ3v1Ec2FH+oujN+24uCUH
         yXAmWlRGgkV80GK9SH6DxwHQ1zYg11wdj/YZErjcuh4FXu8ShQjHII8ojqOpzyioQiJ8
         9njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722028; x=1796326828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1JALepU7GR/x3bHR/X22ZryxO1IhoAlF/ZwBjVERkc=;
        b=CTAtfN6wqFD4/2zu77ZpopxJu/4BLY5/qRTqvhp/rY1SE0ZVupf7/1cyb/gjFIcE7v
         QUh5IdNgfIqiQlwQ7p7eV62ylT0Uq3Q4JKPP4yB9hXssZxDii+6lLASF6su99XS26aVu
         2Ovw0eU6Q/hc0fctP0Vf5BkYSrYAphnmL4aKT7kEGdgaZaaowkqouBnstZ7eTmeXcSMO
         YouZVWEtx7jaJYmOQcvdhWqVNEW6uSkMCSDP4vTyKLjT/KOWxuocRYr7b8i8HfnPNV+H
         YR9gUWdH5FBzNPdwMWeyY5GNJFkqmcTWpIniduMKwISs7g5oKA+DsFxWYbCQoGwZOiza
         KeOQ==
X-Gm-Message-State: APuU4Z+aN5K2DpudRWrOoJTa30k5PEmRd07TVHjWx6uCUMFW9wgnugDm
	wWL2vmyFrZnoCnbuQyihLbVbVhaAnq7pL7Oy8vwX8Od7UysJITGzmBfwblqliO83x3Y2o+OZQ/w
	dcE0+tTcxt3r+/ftsAuc49gj17vyr52VDclvyNSY6BuD9GqgjtlIUVh/0gzCJT8VAU8g1pLiJFx
	n11HBmHkWN0mM9r4/XH1EXjQKuF8p8UlEoDeUAPw==
X-Gm-Gg: AZFdTZc2n6wMrEKlxccE88NfkkzrXYzvg+KrieEir0E65M7HoIT7w4AEzF9teI7Rz2l
	NwVp8Bt9FQswUbTWKwpPUxum/A8tVy9iVnLmzhOJWNv2UNLT0nnM2PNVSCXPBg1dM0ykp5Q3Td/
	8qdhITbGhcz2MSRVEwoo+SeGxAVoW0JHfQwDvbqQJ7+DVIs6+MYvUyZocF
X-Received: by 2002:a05:7301:d805:b0:385:ce95:2e14 with SMTP id 5a478bee46e88-385ce953221mr20846982eec.30.1795722027755;
        Thu, 26 Nov 2026 11:40:27 -0800 (PST)
X-Received: by 2002:a05:7301:d805:b0:385:ce95:2e14 with SMTP id
 5a478bee46e88-385ce953221mr20846969eec.30.1795722027291; Thu, 26 Nov 2026
 11:40:27 -0800 (PST)
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124074531.1701179-1-rc4d5a@protonmail.com>
In-Reply-To: <20261124074531.1701179-1-rc4d5a@protonmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 26 Nov 2026 14:40:15 -0500
X-Gm-Features: Aa3M54pUS8i_NVj6S1gEviSRlU_cYUkcIfq1IIhW5z8VzPWDIC2T6EQTZPDGXFY
Message-ID: <CAK-6q+jR1fZh6PcMKPpQwFW-89GLw6eSuUkC-kCLg+sghO3RpA@mail.gmail.com>
Subject: Re: [PATCH net v5] ieee802154: 6lowpan: validate fragment offset
 against datagram size
To: Ryan Prinz <rc4d5a@protonmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 24, 2026 at 2:46=E2=80=AFAM Ryan Prinz <rc4d5a@protonmail.com> =
wrote:
>
> A 6LoWPAN fragment carries the datagram's total size (d_size) and its
> own offset within it. lowpan_frag_queue() never checks that the
> offset, or offset plus length, fits inside d_size, and never rejects
> an empty fragment.
>
> A datagram is considered complete once enough bytes have been counted
> (fq->q.meat) toward d_size, regardless of whether those bytes actually
> form a contiguous range. So an out-of-range or empty fragment's length
> still counts toward completion, even though it doesn't belong anywhere
> in the datagram.
>
> IPv6's ip6_frag_queue() already bounds each fragment's end against
> IPV6_MAXPLEN and rejects zero-length fragments; 6LoWPAN had no
> equivalent checks.

There is a check [0] to reject d_size above IPV6_MIN_MTU (max ipv6
ressambled packet size), so checking if the offset is in d_size should
be fine and we have something equivalent here.

>
> Fixed by rejecting any fragment that is empty, or whose offset (or
> offset + length) exceeds d_size.
>
> Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_fr=
ag api")
> Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks!

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/6lowpan/reassembly.c?h=3Dv7.4-rc4#n302

