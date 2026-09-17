Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02594EDCB0
	for <linux-wpan@vger.kernel.org>; Thu, 17 Sep 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675895; cv=none; b=PC+8LwfRNb/FsLhYLfnYWRv5tQNqhQxVWGkiX+fVGP0vG+xLvvjPYv8AmPTc/2NYwzCEk6CXDTtFuz3DvfCMqvNiP/v57C68eoA61j8TZCbt7OLwK6Kgk/6qmTYDxcnkrGueMsiRaHYC2ioWKA2WJpnDP1/NY7VIzqSBA2iIPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675895; c=relaxed/simple;
	bh=Pld+KJDf/y0brTSHAZfyNj7LwB26z/vcvvMjg82D16g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H2tSvTqql7iQ0ZsTITCOmMJ5piOkdtdecioQSEjYXyGuJFqX7ZHuaxRl4NEn8J8YpJGB7yozxoVxbgf+iOmX0G+Zv+A1mfov3xwulAwwSuqzwerGbXmZVdfh1lRG7UI/g4eDxK9E5lCKZ2ebrnkDfPqz4yOXPlWHU6P+2Fy2Mmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEG1HNV1; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEG1HNV1"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a3490bso68615b3a.3
        for <linux-wpan@vger.kernel.org>; Thu, 17 Sep 2026 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675884; x=1790280684; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pld+KJDf/y0brTSHAZfyNj7LwB26z/vcvvMjg82D16g=;
        b=jEG1HNV1nB356xIIlFyTqdaGPUUh9EjM/3PMbUs+3AGI4ehoP6+sJVH1PhlKRJdi74
         49iLVhT9tC9NObKt7CYqbEQamlyNxL8drgZcjYZ9wTLMuI4t48nW91cDfveXf0Si7vCw
         54dSWTEmPbs9HqyhwNdcIeab67Tty0F+QyFDkFaySQpj76fSQNllBZtFFvlb1jacOCR2
         FmpL9hmFxdFK867OkjHeAXKI83GK8UB4CV1xuosFIQTGXxVsJUsjkAlXWhAILWlyh4HL
         lpFK8QRjRmw0sPKGRoO7Aa3cih6io/pYDi7ISzk1TEp/o6Wckao1szsQ3Um6dWzlqWkz
         9vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675884; x=1790280684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pld+KJDf/y0brTSHAZfyNj7LwB26z/vcvvMjg82D16g=;
        b=z4f4+Dwb8/Wlt7QVMwQKG53jcVLlRllJmhfeX4V2iUMUK5pVL38a6oFXnTFAVh6tRi
         jpE6OAQhIz7ak/DZ6LxncDBs0R/P3aymmSM8hRj1XqgDJwMxJ4DYg3TpdFlMIKPFcZmd
         byjYhMACxRCI3eVCkHVYQgFhRm6D36pheTev46FPIXypYBFLFmWyAZAD4QOAhKKrZfc1
         G3l7Ztvtmeyf4OuBpleOaKEfC4fJ9ETLqkh/Cl3KQnZnvdrjki7upByLEh9c5hOFA+vg
         WfEMkjkZRmZfwognSzprPaVvxKM5Jm+ZekljUWYO3SybrGT1QBtHqRygBaDxqQG4o6fU
         SLtw==
X-Forwarded-Encrypted: i=1; AKwUvBxFdy+4f+0eYtvIuhaiDuJMheh95KqEhhKDUCW/B97S+8Uw/5WFRUocTkcXO5CEnoSV6hDUDmwMI4fw@vger.kernel.org
X-Gm-Message-State: AFuF++kXduXTlFc2T/ivMJMWaFoEADanPtZgjJA6N2HuUr6fT3PKT9ll
	t6U5E1TSlnDnExIlWFnkd4pMELuxYe01cis8iIuMRGxZLxCYCFqcwsPz
X-Gm-Gg: AYBFou2Ot2EJph8/O/TSp0n9njwA5/V8jSm29jcwW9J/MDg9GCh3eV9AqMVWusaBKHY
	EC0tCFrDIfAFX9lJh1yG4qrfrO0WparQU/5yf2GZP38CnAHi13GuIVMnrYtGJ9q7b2GBavZGW5d
	o5jHCqJUWO1sH47Agw3lbXinJSAsRsft1PqdPoThZ8Xa8lYH6IsRnakuxXAYGbqm049Z9Mkj2Hl
	VS8gmdpLk2wopAgEMuugxChyhIVFd5HuqOwhxzda3Cq5MCFwyM1Q7NChjo7RcDx0rhVXhfMZzXD
	dMtUwLrIrDLR/6zGfCkz98/ilVY1QrFRX5zbQ10yOV5TYjj77fyHxRrb5Nd/EOwZwx5sImScDHw
	B4URvMAZQp1+9xrTkSplJQrTbHIcRnuhUd3zOeVwA6IqZOxRFPeHRtlAIT9Ggefqgl3Oojwg2eY
	j1/oLeH0xMaP3EmCPWLv43RvPmy5iHz5DCRL0fH7ZSQ/4+fCTdyzLwlOL5lOL3UejaCKHu7pqfc
	1423gLK3BJeBIeHRb4FzRVKB4c=
X-Received: by 2002:a05:6a20:cfa2:b0:3dd:5831:ef58 with SMTP id adf61e73a8af0-3dd8c456190mr204908637.15.1789675883461;
        Thu, 17 Sep 2026 13:11:23 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d13ee7sm16211287c88.8.2026.09.17.13.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 20:11:18 +0000
Message-Id: <DLHV5GF21AY4.3GAK241ZI2UR8@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 <netdev@vger.kernel.org>, "Arun Ajith S" <aajith@arista.com>, "Roopa
 Prabhu" <roopa@nvidia.com>, "Jaehee Park" <jhpark1013@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Alexander Aring" <alex.aring@gmail.com>, <linux-wpan@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: "Ido Schimmel" <idosch@nvidia.com>
X-Mailer: aerc 0.17.0
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com> <20260916120202.GA935660@shredder> <DLGXDIB879EO.IDZNAIRY0VFJ@gmail.com> <20260917143750.GA1332286@shredder>
In-Reply-To: <20260917143750.GA1332286@shredder>

On Thu Sep 17, 2026 at 2:37 PM UTC, Ido Schimmel wrote:
> On Wed, Sep 16, 2026 at 05:43:11PM +0000, Lawrence Lee wrote:
> > I added the lowpan changes after my local Sashiko review run=20
> > identified an issue where a FAILED neighbor can retain an outdated=20
> > private short address if it's moved to STALE by a non-override NA.=20
> > Happy to drop all lowpan-related changes or update comments/commit=20
> > message to reflect the changes, please let me know your preference.
>
> And if the entry is INCOMPLETE and we get a non-override NA?
> lowpan_ndisc_update() will ignore it. It's a pre-existing issue and
> there is a TODO comment about this:
>
> "/* react on overrides only. TODO check if this is really right. */"
>
> You can mention that it's a pre-existing issue under the '---'. That
> way, hopefully, Sashiko will not flag it and it won't clutter the git
> log.
>
> > This was added in response to another Sashiko local review finding. =20
> > Let's say we have some FAILED neighbor T with NTF_ROUTER set. If we=20
> > get an NA from source address S with target address T and with the=20
> > Router bit clear, existing kernel code will cleanup routes with=20
> > gateway S, but IMO we should clean routes with gateway T instead=20
> > since that is the neighbor which was updated by the NA. I can either=20
> > update comments/commit message to reflect this or remove the change=20
> > entirely, please let me know your preference.
>
> And if the neighbour was in a different state than FAILED? It seems like
> another pre-existing issue. I guess that in practice, most of the time,
> the source address of the NA is also the target address in the payload.
> You can mention this under the '---'.

I will remove both of these changes, add comments below the '---' as=20
suggested, and resubmit.
