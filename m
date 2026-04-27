Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C731280325
	for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327222; cv=none; b=P8NrvblNXwoUl41F+h3LiWYCOBj7ejN6AfMcKm6jMNUKSUvkgeYzyoDjPCJ2alZp+wVBuTLxmJP19Yu71jNvqplorPMpfgg75gCb/g6rY0DF4HdH+ncTXz4OLX8flfsEVwXiycnqyjcwHttMPmRKaUf4XAhy+cM4nf6hThuDBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327222; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjqTMgf00/oFOFMzg9S29mVd87krGRYwcCfK1oYH47SxFmN6ejL+jtHHyCmnBj12gIznOnVQ0UbQ42KMNhbxwLRUiF67LKCecMoQQ+T2hsl0uRLaymAcgcqSLtTguWwZSrXtIrfyDUf/p/b3JwMHfc8VMREdzB5LnaCByOM+YSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UCsK7tKP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UCsK7tKP"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f9568e074so1773316666b.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327219; x=1777932019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=UCsK7tKPSNpiNAw+tFEmSeNZ9s9Smmf8rXmliW0VU5eKaG2qGqIBk/q2Fj0fkBc355
         Q85ucJDXSbCVI4xwr3oqMLrqwEUOyrg4Z32oKCk6BqcYfPUFoKvKfjvbmDULpNKNgLGR
         aEgJKTeK6v64dpFMslVYGaHo/tD5cU1FphVew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327219; x=1777932019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=W+GBlbPgUpDCSZWZGRrkT21m+8mhPv/4imkNeWsawU+c+kYClkNU+tGOSnodyr+Stq
         oABo7fsqjopXDjBs+ERWyyKsajzM7O2Hm6nSKs0Wydu3zYy1U3rAaddtdTAN4EXUgsLL
         nx12rhq/zvlCAtgN7c6hVYWEkG3uRgRkUz8EJhzVJ/0gjTpwcBZKr5CoIM4/Sxy+KnCC
         ZRdNmrvOCOz1L440Wr4zOWWGXvaf8oMVDFWTImbF1kziDPQI8aGARXTpiMElmBKuO6ud
         DquOAx46guONlBLSlTVFjuoDoPyoZFW+CKqGX717gblGQHPBr+6h4ynA2OxHDDFNJ8Vt
         prKw==
X-Forwarded-Encrypted: i=1; AFNElJ8NEwma2QdO2tkYKuGedxJ7/OmZ6Cpdwbr8ZOwsuT8FuqvlqtnziYT6NUTxmrrG/JLPcl0N6tbFgyOg@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZwaH/Bz4KcyFwFOpY27iDYjbTFsc8k27yAsQLtUJzl+V9tP0
	O0e/kWgFfEp3zKfubmy8ZaL/Fz9i+nlTDpfv6NXy5yrd098ou+Yt4a/q0Sp0X6/bSTaOwzlmkjB
	W7NZ7hnEJ+A==
X-Gm-Gg: AeBDievL/Pj8WDnT125b0zrlOcH6b0QtRpAfacDzXBJ8HhjtocmK+McgvMyXacNPXGC
	VVRwvfeEt1SMgPh7bBLKwryz3cAbofycve+RfIe496srvnAMm68f2ebbl7OvLzgFw//6vZ1pGCP
	oMIdP9oFvmWQCm3ob9Bp81No1r17ushSpN7ZISe7/atQEIN4uAmX1dRSqo/HpTn1FFEoTWrVoYy
	n7RWhnvNf5oxCtcrIwLxEEJlnn3DXa844r4yQHcZZ64hK9A/5Yva1qx+EQR1nudYCxzDaYPndQf
	me40k2m6UhzmS/fW8wABjIXDVXfI3ivN6ffmkdyUWhiqCa5t8Xvd+2zUeoim/GeFf8yXf9KyCvZ
	RI92xtAK1Ahkurnucarqzy4MdiMgMh9RJE5/tJwwylCa+B5BidksnP+QhnCV3MWlvfVnxjoU0k1
	NAs8LWtL5xGLPNCH6xyeNJldmBX8MaBuzLRHpOaOXvuWnuKlJAqFoMx1ZTHnRIJquFoNIMTXTPq
	HK8LBNb20s=
X-Received: by 2002:a17:907:6ea4:b0:ba5:1970:2bb6 with SMTP id a640c23a62f3a-bb803d65634mr29607466b.34.1777327219258;
        Mon, 27 Apr 2026 15:00:19 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c57f559sm10284066b.61.2026.04.27.15.00.19
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 15:00:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10762071a12.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 15:00:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/cbVLNgid3phaL1vlFiKZWQjn95K458aqbKYLYzqFiPSjk1NoRMp4QdYsv53ZTC69pXKbAFjHCVQni@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
