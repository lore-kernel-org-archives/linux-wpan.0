Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF8371D04
	for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325981; cv=none; b=bRLU3gJ33gepvkdnu48ZMJEkOWBTgrKx5uRD9Jmpemo1YbFchErH/oht12fKsF2W81PkyQGFYwfQCH7qHVl0/J6bySQfH574X+NA0shJny7EnjlXLVnNx+UWq+c0LiQ4fUPy5mD1oTyoSmlpnP0UBax0ty0SLpQ7MT3rxaKnlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325981; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxo8SDobKcoz9jrymzADe68YyqtuH4CKzPQsKQbKee+c2KUpeFmarNCo2YlgKN8WuU//n1WAAmvICaloB6+r9KkfcvCnWe0VQXlCfENyobtpRsfDpDwtSFQw7DZ3YUJcgyjtQNMPdqQTndyesWR+12q8O4gbUqYlJItWKRkH+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFh2JxOq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFh2JxOq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f97c626aaso848649866b.2
        for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325978; x=1777930778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=YFh2JxOqJ//ggC9CWdywHAJ9A0NX/NgsQ7R2jTkQJNVXD/6CHxytfyCPfwF8+MTdVb
         juGCSpNMS/sGvVOWkHxsPXpajalDGaurh2iBAxawcWAiAb1DmP1rnKLNwemAooYsPXu9
         qQasAr4UW7MERJzN0kKhw7kbXZp49fe/kXoyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325978; x=1777930778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=FjnV38zpCJIdIBGE+RzgqoeeBz6Hvik3aYRelShTBj0C38P0ufDTTI0nPt+GVY1O0J
         1QyjNqlH2PwoHbe53l9nz1j38D/BWKlTtBo5gQno94Csg6u12QMPQI391ZCQSbe9UjSZ
         CeRy1n81wr98mpL/+Hliv/GNtZrkiO/1s2KHpPrHrW0XTkNVHDZpVkPAPI+cn0g96xQt
         IYfFOCvC6GgoOLuczjFrAVUyqOWuRpMHnL2DGn0Oz5qFMzbsrenEZsP4cdhMJ5RkGDWq
         xPsfPU3VCPGmT9MKFnSlKxehmEDG70dwoHB5rW9oewdT7T4eJ0W1B2ZZtDFGXnudyHEp
         uquQ==
X-Forwarded-Encrypted: i=1; AFNElJ+I/w5eeg0co97fei+TQCdtvNDNI+uQgBm+e4SosLj6eTneAeGIlFhPHeVljEZBcax782tCllOeL/zJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9O/mOjhzT7jFZRHOhtvjZPN69yQ1tOqIc5H+adtUBk+cLhvGV
	qC7hfDl4iSt3Yespc0IzoDgVDF0CxGmfb8+agT+yu9EPC1TcSi1+WakNDrwi4fG21Wrhe4T4d7V
	JmqgNRQhMPQ==
X-Gm-Gg: AeBDiesw9QOTgt2fLi0xZldocdWME08XP7t4T4C6MOWFbHlYDdKLDYiO0e/sJh+ttIT
	MrTG6dim53LexWgdD3LvdhPgY+jUI5xSRyWwKHkAX5TO8Ey2M7BHpOMsczrLnBhc0HgZsleULLj
	B8jcghFH6yVVF2EWN8MGIdnb7pNIXT5AIJV1Xfh6a3PHeEkHXljzqSCYrE2s8kPg/gjylroleWK
	wiT4DlaOqOURe2eW/I8q1RMK9uziwiVFr9FvlRulzTwOcln84Haa0u2MM5+isV7cx3QkH6+zRNd
	EqagcNuZ+NvjtuIfdBMCpPVzFDhxa2CnCs/bbnD9DxnKpmtrEYONidYBar0WJ08UUJSwaFN4Vmc
	9Xwu+z0xUqUJnNN/MiwnET5rQpS9NprxayFJ843uK4OTJPTJD1qQmqrTFs5mpsOq3gh/3qyek25
	q+tliZeDC8CW8KLlw4KV+yBqeIWvfgtyu0KtLDLOAXsUL8IGg3P7XgNtf+gqsnf48GuL+9que8c
	ys6K2hsE/s=
X-Received: by 2002:a17:907:a286:b0:bae:7277:1272 with SMTP id a640c23a62f3a-bb804c3286emr28720766b.36.1777325978004;
        Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adb01sm9184966b.37.2026.04.27.14.39.37
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so18821361a12.2
        for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9H9uLkrQawm8ODtBlc6tz9XuQGFDz2q294FlnXEouAQF3AlsbJiPoIwR3fEKITV5/sNtJE7YzJpgxT@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
