Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629670838
	for <linux-wpan@vger.kernel.org>; Mon,  4 Aug 2025 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275724; cv=none; b=DoK0iEqZDyxdmwqpC11iL7skw5jimERm1Mz/W8548wvsx0lIkWYzpWNhngckRLm0hu8EKAopE75JchM8ccaJY1igF3rQiNyTodw9pJmd/NAIHT80/7+v3ddHDVDKT1Vae1tFtZVpE1zp1HIMHm8iARhA+anqAgJ2Wm/b8xTWQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275724; c=relaxed/simple;
	bh=6g6PllBQ6VS1WI/mxLGQjR9treAys8wTQYmr7QvgDps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nwBdJufaerwdL711p0/CXb3Fhw5EjXkTloIyOJpVAkqEDLDks6157B8aUT8llz10R0zm4skd5NGT8hx6SlxVsU85TramG9ZbV8BAlJhmZj3YeX6D7ikTi6A8+z7kqfc+b5KIrotO9hrsIGnvGkRF2VxKpmkKsZZavYGPglIBLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNWp6fqQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNWp6fqQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso148752766b.1
        for <linux-wpan@vger.kernel.org>; Sun, 03 Aug 2025 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754275720; x=1754880520; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zmSxg/q41nLk5JlGBwtyXZo/x57cKZemlFoPpruhlk=;
        b=mNWp6fqQwNDnwCh+gwrPseR6Od9eIxatFyjjlvWclWPy/EqWQ2q9nYX5thgA5VAZpv
         laQQZYPfoGWkvAD/oRcn2xqIDnJ8mdYtPyS0DImbOZAYwSlJEFAho609iboMsKQ9aifW
         0qTxDganupNIqDLQNMgAasATbLnY7ZxFzi3gdIcFjSxKkLdwYwOB2ILYY4gMT+buIo06
         IwsP+AMWbUGH3qn3JX4qHjUVl6TA1sb7lqN76+d53i8JbaIMkR6bs9lg8XN5a+YV1Sgw
         E04lwvAEi4Oo9n/SLhIUDOyLamgD55wwu8FDL4Brx1MC306gvQSAeMr1MDozAxLkpRyD
         DhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275720; x=1754880520;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zmSxg/q41nLk5JlGBwtyXZo/x57cKZemlFoPpruhlk=;
        b=UliL68EXkEMZq1rsQ4X19sl+HZKftnIoKDkI/DiDsHyqnGdFBFlse51SO04qVlV+St
         eEmNGptHMbxvG4LL65Xv3g89fUxt3OfP2ANzUx30tL60NM5fI8Xf+a69HiWN3Wiuw6s+
         Gwu60o7P7NZ3kwMzTwLqKkpob+PbaCriQbJmIZ4VtV/d5ESxziU03hn1ZL3miv91LKbS
         6xq80871ZTB5N57eEVBSYG7ZzIvwU7P8IVWGwo6Aq/nNkXV7N4/6dZLXmZc6cWLXfBpW
         Pxuv1yl9pVPlV3d85gneianiSKdWhb3m4QrkufsumLqxMOug01p5u6R15ZDnqOLH2i7g
         rOdg==
X-Gm-Message-State: AOJu0Yx015LUHNijqBWlkMfUFb6uZL5j2E9P/42fU0VQlq99ksz/e+FS
	uzugGqf2QWyg1doa58HCyvHtxqYpNeaYMiL3cs/Dmc1voqNFsb+LHWBqoBoWAM9RQo4hgBDOqHi
	OQACqT7XvkJ3b99erkPNTGuPCiJgJ/FmLatPjl9o=
X-Gm-Gg: ASbGncs+5fYbJQab6ecQ2F6XTPViVSHZIb7x+S8cQ9emW5zplx59LdPsKdGY+pfXbIc
	XyMC9lUz286vFLghLkm3SDdMLjwAaoFiP9H7niyRKSSPBFFl1dRPLBWOCOi4uCUUiZg4G2uFpno
	jaiaL5St2lcPhuRzy5nGX/TP4OW7hYiuPSv2xzPPpmibRGVPkZjSqIlWWnQOsMkXM5ehG64xI8+
	UGq3sLA0cqmdR+C+mUkuMG0usu6h27yLOo=
X-Google-Smtp-Source: AGHT+IHSQ03jVnVEY2/lt03ABYEUP2Mn3/LWsWoCoGMQmodZ5XOKi0+J4fTA2ttCUrjimOdiDdLl2jBNoreAIUslRUw=
X-Received: by 2002:a17:907:3f2a:b0:af9:3019:6aef with SMTP id
 a640c23a62f3a-af93ffbee9emr878650266b.10.1754275720455; Sun, 03 Aug 2025
 19:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: manas gupta <manasgupta3131@gmail.com>
Date: Mon, 4 Aug 2025 08:18:28 +0530
X-Gm-Features: Ac12FXxazEAEIpkwN3E_loKCtiqQcR6oVbVHgY86AjQkNENHyG27Y_jf1G2kzyE
Message-ID: <CAJ9b4C22ZM9RKMDo+1U9gdK8e4iewKaz8vdO7xjmKytJ1fjrRg@mail.gmail.com>
Subject: Re: [RFC] GSoC 2025 upstream wpanusb bcfserial
To: linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi all,

I'm Manas, a GSoC 2025 contributor @BeagleBoard org working on the
project upstream wpanusb bcferial as part of my efforts I am aiming to
upstream these drivers to simplify on-going support.

I'm writing to this list to introduce the project, share the progress
made so far, and respectfully ask for your guidance on the best path
forward for upstreaming the drivers.

The drivers have had multiple functional gaps before they can be
upstreamed, over the past few weeks I have been working on quite a few
of them.

To address the first major gap, I have spent the initial phase of the
project implementing the missing driver operations. The driver now has
functional implementations for:
set_txpower(), set_lbt(), set_cca_mode(), set_cca_ed_level(),
set_csma_params(), set_frame_retries(), set_promiscuous_mode(),
Enhanced parameter validation per IEEE 802.15.4 standard, Improved
error handling and debug logging and worked on the zephyr application.
Currently I am working on generic aspects which are hardcoded and
Dynamic device capabilities.
>Stefan's notes mentioned heavy work on management frames and scanning. Are there any new driver ops or architectural changes on the horizon that I should be aware of and plan for in this driver?

I am eager to contribute and follow the best practices of the kernel
community. Any feedback on the work so far, patch submission
strategies and guidance would be incredibly valuable.

Based on community feedback, I plan to:
  1. Address any architectural concerns raised
  2. Implement suggested improvements
  3. Prepare formal patch series for submission
  4. Coordinate hardware testing with BeagleConnect devices
  5. Document any remaining limitations

I would greatly appreciate any guidance on:
  - Code review and architectural feedback
  - Upstreaming process and requirements
  - Testing strategies and requirements

Thank you for your time and consideration. I look forward to contributing to
the Linux IEEE 802.15.4 subsystem.

project forum link:
https://forum.beagleboard.org/t/upstream-wpanusb-and-bcfserial/37186

gsoc page- https://summerofcode.withgoogle.com/programs/2025/projects/xZofecH8
org repo link: https://openbeagle.org/beagleconnect/linux

my repo links
wpanusb driver: https://github.com/manas-gupta-3131/bb-gsoc-wpanusb
bcfserial driver: https://github.com/manas-gupta-3131/bb-gsoc-bcfserial
wpanusb_bc(zephyr application):
https://github.com/manas-gupta-3131/bb-gsoc-wpanusb_bc


-Manas
 GSoC 25
