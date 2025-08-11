Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0626AE4
	for <linux-wpan@vger.kernel.org>; Mon, 11 Aug 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914402; cv=none; b=Ikz5uN0nieuawa2KU/d9OmMNgABi3iVKCxStEYVoT5j+pfv1POmBlyQlXuASagL1t7CEGquIKdHNqXPPt1dtMaML+QxS7W0kKzLq5U1wAmsM54aiwn7aDSwcSYcJUQY+evJJQGYzw3KrIB9poebxV/jIGQojPIyoGN1Y5qay9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914402; c=relaxed/simple;
	bh=8YfPNiaXOdGMtrk/w0hcpMgykpF64GJUJD70UJZUUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odcdduerGGdT498CIVpxFEuTzk6cWTsW+kO2TidY1NuoWTLH4T4V/FKRNYdxHqvff8OLFHmY4NBQ+4zbkNx5hgCnXiB8xRaIkzBdo7jRB6uZRAhwygfSn2MZywwBMxdQ+vCURCE+q8EolLEodDzr/uVNl3Edn5VnSr04FP8t9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMyS03Rp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMyS03Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754914400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzetrqawSO/jDpIpq7YpjQHC+ZPc26oYz2XZ2Xsvkjg=;
	b=XMyS03RpubzPPTNRGF9UYrFCNmAsWwH07xL7JGVBA9WXx3xvtFquEtKt+A+N+jLwyEuzix
	45R8RFPHtn6i1p6gQZUe+N46M7cavdsyEVq+v5Y7jjrbmoop3Jn0lO2Yc/bKJUZc68Kqr/
	HvFj47SwWwW8T2QxVvZjUMaQ+DI9+cQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-K7yE9UeHP821ChTJeEQ6CA-1; Mon, 11 Aug 2025 08:13:17 -0400
X-MC-Unique: K7yE9UeHP821ChTJeEQ6CA-1
X-Mimecast-MFC-AGG-ID: K7yE9UeHP821ChTJeEQ6CA_1754914396
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55b9b0cb673so2287115e87.2
        for <linux-wpan@vger.kernel.org>; Mon, 11 Aug 2025 05:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914396; x=1755519196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzetrqawSO/jDpIpq7YpjQHC+ZPc26oYz2XZ2Xsvkjg=;
        b=GxAnBrVGSw/dRvO6m8jvccsVaOhRKUT5bli78vFlxPtcVVmOHMJ11SnNmZjC18XrcM
         h9ZCdAGEarRE1k75aVr6neqoScW6BUI/xOa6wcEazerhSnMHDdeaDL8UNsBoWDC8DnFl
         SaQ5ZFJ8F2w+RpFTmUly4NO8wTHoLBHRChZ9kBxaSn6GBihnrVvPtDvry9aNOkFc3VyL
         z/GRAMkWIgjhVRFMBEUswXs46DRWnIBIJ7byvBwJ0QMl1pM8TvGw1QYypDyuao0yHA9z
         UKKVlKsbVjk8zTL+UJ7LmExWuZsgFbNiVqK65SqexGeK3YwePRUci7vmiTfBb2Yp/SP2
         TCVg==
X-Gm-Message-State: AOJu0YzPE2thVnZkXNFY4IGzwyd1+UE8YKzVjW7phqC1AQC2lS0H8XVA
	ONjr0WmWRrXNzU2/TODwWRzbw0nPTWHrHQexGofKjyOPq/lNkIQ3ecq5NxIq8LnEmvPm4AB9+rY
	CF+myyO61TG3ZoqLj0MbTydNpkbnTC9LtQ8cM1UUt6X8++XpLUJTxDO+/ahTc3SxGQ1fb6SFgfa
	rrirx2j4siXIF+QGXMMdml8lZo2ewXBUCMfhFPFQ==
X-Gm-Gg: ASbGncsB3aSyiFJLaQWDtNae6Zz7BVt6j1v/cQlV23dj8TF87PUw7iPxUEthzAZpTsL
	kq8N9o9a1aFy2LAXz65JJ4U7RLQ3f1AM4FzqEyxnKmRTLWB02pUpNGETvMIDN316rEj4bz04S44
	VaNxD0m5HKa19eQA5Aq4o6IfEIBBEbFjlzWO/B//4rnp1cMHNBcb5vo84=
X-Received: by 2002:a05:6512:3ba3:b0:55b:9388:f14e with SMTP id 2adb3069b0e04-55cc015d0cfmr3031126e87.53.1754914394775;
        Mon, 11 Aug 2025 05:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlJPUdhgOih/zdAIlbOhEwaCW0zyr/jCs6C3zhXS/2DH2Ar+d/W1YmoTzWyYgBVoPUfAm4S7wDQNdP2RNfVaw=
X-Received: by 2002:a05:6512:3ba3:b0:55b:9388:f14e with SMTP id
 2adb3069b0e04-55cc015d0cfmr3031108e87.53.1754914393999; Mon, 11 Aug 2025
 05:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ9b4C22ZM9RKMDo+1U9gdK8e4iewKaz8vdO7xjmKytJ1fjrRg@mail.gmail.com>
In-Reply-To: <CAJ9b4C22ZM9RKMDo+1U9gdK8e4iewKaz8vdO7xjmKytJ1fjrRg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 11 Aug 2025 08:13:02 -0400
X-Gm-Features: Ac12FXwXPvsnve_NFlQ3UDR4o9cM0eVMJAo3ZjnzpH68w39wRGCWNlLDsXAEwh0
Message-ID: <CAK-6q+ic4j=g4gqmt=Uf7bzh7Mq8YGLSs8WAWY8AzUiGzAVBMA@mail.gmail.com>
Subject: Re: [RFC] GSoC 2025 upstream wpanusb bcfserial
To: manas gupta <manasgupta3131@gmail.com>
Cc: linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 3, 2025 at 10:48=E2=80=AFPM manas gupta <manasgupta3131@gmail.c=
om> wrote:
>
> hi all,
>
> I'm Manas, a GSoC 2025 contributor @BeagleBoard org working on the
> project upstream wpanusb bcferial as part of my efforts I am aiming to
> upstream these drivers to simplify on-going support.
>
> I'm writing to this list to introduce the project, share the progress
> made so far, and respectfully ask for your guidance on the best path
> forward for upstreaming the drivers.
>
> The drivers have had multiple functional gaps before they can be
> upstreamed, over the past few weeks I have been working on quite a few
> of them.
>
> To address the first major gap, I have spent the initial phase of the
> project implementing the missing driver operations. The driver now has
> functional implementations for:
> set_txpower(), set_lbt(), set_cca_mode(), set_cca_ed_level(),
> set_csma_params(), set_frame_retries(), set_promiscuous_mode(),
> Enhanced parameter validation per IEEE 802.15.4 standard, Improved
> error handling and debug logging and worked on the zephyr application.
> Currently I am working on generic aspects which are hardcoded and
> Dynamic device capabilities.
> >Stefan's notes mentioned heavy work on management frames and scanning. A=
re there any new driver ops or architectural changes on the horizon that I =
should be aware of and plan for in this driver?
>
> I am eager to contribute and follow the best practices of the kernel
> community. Any feedback on the work so far, patch submission
> strategies and guidance would be incredibly valuable.
>
> Based on community feedback, I plan to:
>   1. Address any architectural concerns raised

SoftMAC vs HardMAC, look at timing critical "things".

>   2. Implement suggested improvements

make atusb more generic?

>   3. Prepare formal patch series for submission

just send patches marked as RFC.

>   4. Coordinate hardware testing with BeagleConnect devices

if its used a serial connection over usb? (You don't need to do that)
maybe virtual dummy that can be connected with hwsim?

>   5. Document any remaining limitations
>

Use documentation/ in the kernel source, but be warned we don't update
them a lot...


> I would greatly appreciate any guidance on:
>   - Code review and architectural feedback
>   - Upstreaming process and requirements

Look in "documentation/".

>   - Testing strategies and requirements

If you say you tested it and I don't have the hardware I need to trust
you... however the mentioned above to have a way to connect it to
hwsim it would be nice.

We make a difference between HardMAC and SoftMAC. It depends how much
MAC logic (especially MLME-ops are done on the firmware of the
transceiver) although SoftMAC also does some MAC functionality that is
necessarily to run on the firmware because of timing critical
infrastructure, e.g. AACK/ARET handling.

Given the fact that we support SoftMAC you probably want to have a
SoftMAC firmware/driver. I think it is best to look at several SoftMAC
transceivers, also on atusb, atusb is very specific to the current
transceiver which is soldered on the transceiver stick. You should be
able to make some "generic" layer on top to do something that your
firmware supports the specific transceiver but the driver on the Linux
side stays the same.

Bluetooth has HCI which is part of their stack (one reason why it is
successful) but wpan IEEE standard doesn't do such specification, you
are on your own here to establish an open one which might others will
follow or not.

- Alex

