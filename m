Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F273A9636
	for <linux-wpan@vger.kernel.org>; Wed,  2 Sep 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344214; cv=pass; b=KxWM93ARP1u44Ki/JxyQeEd8zBlKhtI9C3RkgLZcf3tFto+8KdFzO/dGR2TOK3b0zT2BGbUAHLymC/vJlB6WC00hKjoZ3LPEasjyBEMbrr+3kw0RvKXckWWOe07+Aqb3y/gplfMz3Xn9Jd2pJ8Aied5E1L1wcNTXAog0ae2tyus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344214; c=relaxed/simple;
	bh=OxkC+UQNPmTnPjpxYR7wsxARRTLqWm6Mfgpq9rElfgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLXgV2Q3eyr4sEXdDn8WCCb1kjd6lMnT2+HaP3APcIXWmwicxTWD3pXfIHxQ36xQdGrTjCvNRvWMvPlvQaea1rWnNNFSABeauLEPpFRiSFySz4n8WGg3Eul0a/oQQcBXxVgUkxs96S/hpYBH7qcQlBFQVg2/XGmaGf1sA1Uvdz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MTVEzfE8; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MTVEzfE8"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a1981228f8so8221131fa.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2026 03:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788344209; cv=none;
        d=google.com; s=arc-20260327;
        b=osQknsdTM4Nk5ASR3nhC/ovKFRyd7DsUbi3ssGtdQnDJ8BYgRIjoGD/KL4boPmlF+M
         LWc4kEM+gfpAuX6pOZp9kBzn7J0stznlowBX1PpO5Ru71X3bjjjWgdPsVlPvVKkMnK6k
         Uw+PP9LWp2e7cN0y8x5jX5pd3WV+IacgEJ/aSPD+pikUJB8bFuw2gad7ihnljfW7S36D
         shIrBvu7OK3R1ObrAmxwyULUUo3ZkZ6Ct0sXyAZ1SIm+a1G7HXZS51oxpFF7s7dDP2te
         kpG98YxapbHJHPEKvIy0OjPwUzBxZpdbkFkq2GVSwyZNiZKASHU5tdKpfC/bM+LlMiC1
         KWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        fh=oF4mwV+SeHJf8UUTvs1IZk9Kgv7xpQpSEy2NVdw7wXc=;
        b=OSr8O9BLqfoW55aPwa3by85DFlN+RX28EYvvVafYIf33AapbjJfxPFkTTJYJvkW/ue
         J1K2FTAVoZEHVz5pRB+aajny011YWtXIVloVYptDsJnCImPGFfGzd+z639UlcN4tPrRw
         Q8Vl5OFHWTmWoKiPAYjR7iEZEcRgfoDPKujh6FoaQ/zfr+/ydq/uoGmE0JPdyvy/L9gr
         Y8O1xLac9wurNVrh9GUpHvq2SOYVbpCWAZI9otC41zl57EBbVtfYU8dry6V1RHUZVa4C
         B3mwI5o2e1EaiXX6gxOgvMn/VYUkMW0s2Pgr1xRE0/cAAfroSn90b2wV8AvKKPEdUUiY
         zlSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788344209; x=1788949009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        b=MTVEzfE84KflnmDn4ziageLEu/D8SOGpyoyupJ0tsX/G5RunaIwKjo+yGoWN0t9OPv
         VG+tES8SI7L/gKM5X4Ek5KpItr56U2qeDo/Ims5lIWLOCXX1pGNl6rIs90yK8l4XkSuA
         Dv7XfNaiWo5s5HuSNO5W9W0y/6EAai4V8x6NuTangx6dnz7YHjapOn2k7vJTZSCHB/GO
         xwbi+o9aGwKU1pNaXYPfoBroT5RuWwuEzElixpMxOx9gu7+nFuI+H0Zeatbf7pqZxzt5
         5EcAaUWcuHo/WT4zy4Yr7Q9eKp556j2iRqDs7WqQfpenvQCmkTbFD2CVCoGWmMyerTk1
         MEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344209; x=1788949009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        b=cw2zaPtWliuBgZFntxsyIfFU/glXDPQ0czKZR0vkuI+4kkYD745kkY0lDvHlPMSbra
         QKkRI02QBpyhko0j/7q5GMVaCkbmqjfV4dwLcCe0DOfUEHEvfY6j3Qh1ce7HsGCwulJx
         BSZwAoVk6ymaTAVuPAWnzQxQ9jcRLjHUqRoowraVf8c2zqt4gOG7YZa6kiIOuOcv8kqW
         22lnPEHphXFOaZu0sRy2iyH7WTfNspuKufGBwNAZrXChNxSpl7CU1igx9vzhRboJMFkR
         +NVq6Vuj6lO3aEkgk1n6150zBCyOdJG8bLUy6Ri/NB4UY9g/J4Jgp8v0F/LkL0nr3Nue
         igpg==
X-Gm-Message-State: AFuF++kioK9OO5I1qTwIomZOg3jqbOHl4VaSNS5x3yaY3Icgo3mg+yvK
	lmUnJdsP1inMkH23cel5MnvEQ+8VeyQmf8b+S1BZCjC+BfMsYbuB1vsM/8ufTPsW0Jd2JbgaWzx
	oHuTAEPPaeSi1Vl0f9q6IRNPYw2OGXDFee8SmpSSVocI=
X-Gm-Gg: AYBFou34piiJys3K9CkkD52k5a5FjdfCtLiGy1af7zU2GSR8vNcgppmDSrj3c60FJom
	HQ7R7Pq5H1sEMSs1ukw6WwsKIvlIiJvWCsqR8qoe3X8x7glTR6IOtwGy2lTvPoFMQ32PNBtt9eK
	7BSWjzFEdnY14tPxWfj0pGLeV5m1H5UeV1jb1MjfSfvT71uOTU1NlIE0uPwfFkvlbOErVEBlD2D
	RzbYwgKVdqRH7gClyaxD8mXWU2m/gkc8fjfhyUKgAwTGE7DmE39wAPDqakp9Jy0U4voBEFeDhJz
	mcCird8lnw7wpo+QMTxcTVfbwaRA2MAy8MwIxTs4+g05PwioVB1Afk9wTvt4Nh11VXVIeIuPVXM
	hY8ErT0+c9zBx
X-Received: by 2002:a05:651c:1443:b0:3a3:1391:fb19 with SMTP id
 38308e7fff4ca-3a34ff11646mr8038211fa.9.1788344209091; Wed, 02 Sep 2026
 03:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785596603.git.zihanx@nebusec.ai> <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
 <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
In-Reply-To: <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 2 Sep 2026 18:16:35 +0800
X-Gm-Features: AcwNN1VJQMwlHjV16Apj6_hoFNf4qd9w8vLJXYoDBFJHRBvXJSk1cx2HQCyvrMc
Message-ID: <CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon worker
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com, 
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, david.girault@qorvo.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:15=E2=80=AFPM Stefan Schmidt <stefan@datenfreihafe=
n.org> wrote:
>
> Hello Zihan,
>
> On 8/2/26 11:23, Zihan Xi wrote:
> > mac802154_beacon_worker() reads local->beacon_req under RCU and derives
> > the sub-interface from the request, but then drops the RCU read lock an=
d
> > continues to use both sdata and the embedded wpan_dev.
> >
> > mac802154_stop_beacons_locked() cancels only pending beacon work, clear=
s
> > local->beacon_req and frees the request.  A beacon worker that is alrea=
dy
> > running can therefore continue after interface teardown and dereference
> > the freed netdev private area.
> >
> > The scan worker already pins the netdev before leaving RCU.  Apply the
> > same lifetime rule to the beacon worker: take a netdev reference while
> > the request is still protected by RCU, and release it on all paths that
> > continue after the reference is acquired.
> >
> > Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >   net/mac802154/scan.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > index 65089826f..ebd092d40 100644
> > --- a/net/mac802154/scan.c
> > +++ b/net/mac802154/scan.c
> > @@ -416,6 +416,7 @@ void mac802154_beacon_worker(struct work_struct *wo=
rk)
> >       struct cfg802154_beacon_request *beacon_req;
> >       struct ieee802154_sub_if_data *sdata;
> >       struct wpan_dev *wpan_dev;
> > +     netdevice_tracker dev_tracker;
> >       u8 interval;
> >       int ret;
> >
> > @@ -427,12 +428,14 @@ void mac802154_beacon_worker(struct work_struct *=
work)
> >       }
> >
> >       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
> > +     netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
> >
> >       /* Wait an arbitrary amount of time in case we cannot use the dev=
ice */
> >       if (local->suspended || !ieee802154_sdata_running(sdata)) {
> >               rcu_read_unlock();
> >               queue_delayed_work(local->mac_wq, &local->beacon_work,
> >                                  msecs_to_jiffies(1000));
> > +             netdev_put(sdata->dev, &dev_tracker);
> >               return;
> >       }
> >
> > @@ -450,6 +453,7 @@ void mac802154_beacon_worker(struct work_struct *wo=
rk)
> >       if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
> >               queue_delayed_work(local->mac_wq, &local->beacon_work,
> >                                  local->beacon_interval);
> > +     netdev_put(sdata->dev, &dev_tracker);
> >   }
> >
> >   int mac802154_stop_beacons_locked(struct ieee802154_local *local,
>
>
> This patch does no longer apply. Please rebase and re-send.
>
> regards
> Stefan Schmidt

Hi Stefan,

thanks for taking a look.

This change already landed in net.git as 5f26a690e8ef
("mac802154: fix netdev use-after-free in beacon worker"),
applied by Jakub with Miquel's Reviewed-by.

If wpan.git still needs a rebased copy, I can send that. Otherwise
I will leave it as is to avoid a duplicate.

Thanks,
Zihan
