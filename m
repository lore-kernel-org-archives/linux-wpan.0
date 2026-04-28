Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9249394474
	for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368634; cv=none; b=gARPG+10r0gakLRMhWwnnzmq2/FgTz2LxBURCWTVQ4pAG/jhcmwTDgmqEfz5sV9HYxFJKNXWjPNN7cEXIq46PHuwVClKKRNVH7vt70xxe7zU1hY3NyHjtnuc4GClcPv+bPasUzNqAs9aYynu/fYW6lUq4H1WECnWgu2ID9Y5YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368634; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAUS41T5Cm9VdVl4YLdJgTLu1Tez/UbKyh+j7qd2P7z82Yt1vMcO0LbKcE2ARtPadgOPObf/kFUTPIL5e6ZMyfDiVOMGWvEDmpP5wW+WgRXuVRe6Qbl2fsiXI55q+I1KW33sgf9jvbYsoWBkaHtmUW7oEwUWZqoN49cV2gc/vIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so6415710a12.3
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2026 02:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368629; x=1777973429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=CV3QMFCMVef/sYesTBAtCWkAWMG9P1q4j0D68tZ9x31UK4BvndBBaILrCNwO4d0prq
         GYlKkqRQg1x8CLrqydVqCffAOQXwtK9/nDRGsRXr6iEQWAIfMkttn1+bZ1gNVhYPU+Q9
         t/35lDw7/ziQpUMvtfgz6dCChc8mJbSK7W+ToK5k8V3MjY03WN66XTvzRQpprmlBvI0o
         pN6DXVM9Ut+rzbwaOmee+NOWhOvp1QYnRxYoHAXWzx4yZsaegybJq85qWkF29w0/o8h2
         AWnY1x0rSuDP6IyQVCccOu0ASoavKLjBeNn9DoHy58/54wKESSG45G/k4ieLro21uY/d
         fBAg==
X-Forwarded-Encrypted: i=1; AFNElJ/2JnzPOm1GOgUHBAIIuM/I/nBwx0g1t0CJ4Llzafr0Yy+8dF+zz5lkWoYc7HORCRVCgTcf6vu84eQH@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUYnqOz8n0RovHOEtbtrVNThcbgNyVwznOsmKwTKsLYjYGpcA
	3kdvDQZKg+3mfgT/lglcJxEKvvaur7TPHSNz8bizinOWXus6TNrh5LN7++22+ogbhq4=
X-Gm-Gg: AeBDiev1xlg2gKYNdswBr5jl4wVjkIavFNNqi0fXsDJ6wqIwT9v6lB6xZSeKs5J+psU
	WMQC6oVNKIjgHW258gzApMU9Jaig9LgQQowiFT/iYr3Efe/gEzvMX8JmuLWrgcsqr5Y/cWy5o9m
	lKzZgul4Pxf2+zqNhCDLxifWq78RFA8Ml0RxHf1WTWaRTKd84vf6Zp7W1Ahcj0avgSzX29x6BmP
	ZEvbjzQH6DvStV9ATykuuNeWhFYDzVaBMhPm9LwkFewws9sTLMKo8EQ8/UGkqMGVsLWC7+cTP21
	VpuM93igOJMF8Uk7/+T7OHSOFzQT6hf+eEgrTuIsD8Bu0hFmJvI+hctks1MqQn9V1Dz4gFCaAdh
	qAQm65HA1MmMYdRkvEQbt3CPppfxa1gKw9KieUIVMxvufMgsy3Y/aUzsCwO1sptOsfldkJn67/X
	gVIsLOUF8LtX/LyOqkUSpfGx8hIz3Cmj9rTih6TVDaNFNc1cf56QVOpLXch+nQIiIZwetGkB4=
X-Received: by 2002:a05:6402:3510:b0:672:7109:61a0 with SMTP id 4fb4d7f45d1cf-679bb060f4bmr1043979a12.9.1777368628421;
        Tue, 28 Apr 2026 02:30:28 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5eb1sm511654a12.10.2026.04.28.02.30.27
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:30:28 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso932329066b.2
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2026 02:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9JtxaLy1WaI/3IXAAh47Bh3jS1l/qTcTH6YV6fM9eOQms/sK27oldMSk+I/YAcZ494qQqRUCXzCR1d@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
