Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C283B7759
	for <linux-wpan@vger.kernel.org>; Fri,  3 Jul 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077587; cv=pass; b=NJmOsYvN8PByXCcEcuTjmG0JYINdnMO+D00p3QamDxN1eQuR8fhXu5XIQE+qVj6JdWvtORZMqTpfqp0f5Y3ZjdJ7Mrwn/OK1WzcTizWRPjgJXv+yrrgyUuV2+psxvEgFLvTvrT6/Q8zAqffZVb9ZPMmFHXdulCtVj0/JG5v5S3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077587; c=relaxed/simple;
	bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTbLkAZORcUbBpjURUQG+NxYcR3D665oi9t5/6Ak1t6niRL27CcbOc5iz/QZlcaSklCaO/WiRcKb/smkKcq3mODGRfDG4aRUOouqOHaOsej8W3GQEiBabEGWn3J6KzWWA19snspOWtOWmrxE2Mk/50DNXF7R01TIxwpI62+/5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTDZ1FAy; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTDZ1FAy"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80e24970f1dso3415227b3.0
        for <linux-wpan@vger.kernel.org>; Fri, 03 Jul 2026 04:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077584; cv=none;
        d=google.com; s=arc-20260327;
        b=ZeQaLywK3lMLP2WytHa6Wvq48TsZA23OnsHSdvSEa4BTX23nTJqEobczCrqtULSCZa
         pPAra9erTBTlWGRLkC1LrSsF7L0AwU+B5by0DTXoJRA66cZWtLXYaD4vdxFeTAQcHhur
         Lhq6rwNcCJVBgk03VyLtSc7aNEjxvv8+XzV7m3ghJKgKrQssV4g+5d49ql5Tj627m53a
         oxAZb1RoiJoDjuaVHqJHPkTt4jP6oVYhoxY9lQrW2KmSssACF+LoqmZGgV+zUN6JZuEO
         1YQm8vUZSo8HFCfI1icjuET1dqEpWBGgPuFf5nmpult8iX3feOw315jKiN1cdkUEJJlB
         oBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        fh=w3NQmrOjNC3bUqJXVn3KFdh1+p/9xarWBjOVB6olruw=;
        b=j4pJLN6mo3rMX9E9cc9Vj5DDKLcwiBiUJe0LvdxBQT4nhJXHFNncd5s1jgwJcDTUov
         Ri33ec5oIc8GdoIacHOAi2X2d23xIKivr39655j38G0wvoEZpmxn6XqBMOSJuZ/flv1G
         G8xzy1MxnNkxzkN+1o6+OGVkxVrt+E0xhUKncw6jEc/x9np5Wm5UdWTRU34d9rXbUeYb
         lvIkfF9saKTf6Hn+qX98iLYLTiWhQVK/8yrV67XLAqtu7UX4oNhKJxQeSDFLxb4cBTVE
         i42LlRDpkLa7NoRWknztmoFsvOJbgkQarbXCZqUR6NNxsqeQi8cjuYRAloDlQkrcLl3k
         lLOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077584; x=1783682384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=JTDZ1FAy0nlpJMAUJk4fkIaePwrfF8e7uiKGYwEQQc6VQ9EjRyMHgZyG8rCDATz50G
         AASt8bINGeFULCGM3bF5Uq7GquZ783w9NHJ/iryn/OqkOsK/YbPF8d1MaWiserKBEfU5
         PphJ6xcZGvykbwfxUg2c2oTNoOxIAwHlZBCi1PWzaydsPj2iOi6xMLwUlfi55d5sh39f
         iQ1YbbMEdCLOJ+OzWfNWWK+tv2VjSEdgMZ/CE3C6GUFkJ5GC9geumnyRsPNkm5myGJ7D
         vzYlGpg3IRpuCvOMReRkHyPo92gSv/AKGOlfAMObDAdKf/UL8NLAwM/8rRxm/AmT3gQg
         kVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077584; x=1783682384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=hkj1jKsRzlCvlM4Vu+xEmIC+UOUJe0MDZFLdPs8VJJM9LKlLDUHJGJy/3vwn2uuXu/
         1PufOnLEbIHBiW6HBJk+OyNUi26gYczoUKA8USujG7fIJYxejN3cTYLuPI1UlgUjKLN4
         Ft80ENTKZzimUs3rimE/il32EDPOlkoz7pbyFElaNyOumd48eZcQy9EzZEqfwXQAZT47
         h0H4ryhpvf92bnh1YobiFgvDRAKsuABo+mW+tuIUU3TTZa58QQAsQUVZKxStU5ZJHC3h
         VNw5S0ppZPljLtzG0eG0sRBJ0Lq6EYVuH9iHO2mUOGyyPFIVJ5pb0m3zvgUsGhZQyuCv
         RGSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeL2hx16FQH3ZNi1bSQ3XgOshowIWGTzANPuJq1DI65zONtEw9MMipqHYCSxTudZDBfF6yKPXSgFZa@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHu1CIVgxtVjqKe/3g+C2bpMUrUqJhBIiPlNQt+6OKzzXSu4e
	OS05pfM5E1eh6TmgQOaDDI8zkTj8yJmyTx0/XGrvqCHU3HMbvApyjnRkXZoZ5Z1qp0VGjh1hEsA
	kZuINuqkc/C6ba4WXuriEUCGbCjnSCcA=
X-Gm-Gg: AfdE7cl2vR7EpnVjxJEwpqH5+uWGJPtKx9NaE42N8nYOoGipJUBtuPMhBlgeQw1a9H3
	c9OG2meyfc7zKSd0ookUbQxGYlc46qCYmfdVdGFJG1QQgkozZL7+ILMIfRcZvM9ySPwEFcgkyXf
	mCF9ZvMAPpxUONaKtqEw3H6T0ffgvOAKC1ZhclPlbxZZ6LkAHrDxHQx4XGQluA5IuddE4mhVbLU
	Gg7bAJHcbsdkW0nnDP8d01KVcnBz1LAtDJ7ha5XfCebkZ9ULtg48BZqjAZEo2Lepw5CJGfz2w==
X-Received: by 2002:a05:690c:7307:b0:80c:85e5:8749 with SMTP id
 00721157ae682-8138b1721b7mr93282977b3.71.1783077584023; Fri, 03 Jul 2026
 04:19:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:42 -0700
In-Reply-To: <877bncnx25.fsf@bootlin.com>
References: <20260627235805.17310-1-alhouseenyousef@gmail.com> <877bncnx25.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 04:19:42 -0700
X-Gm-Features: AVVi8CcoY5btWDQlEBKCdQnuzHazbJEJeoWIsXdznqL3lACOC9I6h18j1gdrN64
Message-ID: <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Miquel,

After ieee802154_unregister_hw() returns, the driver callbacks that
can replace phy->pib have been quiesced, and hwsim_del() has exclusive
ownership of the final teardown. The pointer is no longer being
fetched inside an RCU read-side critical section, so rcu_dereference()
is not appropriate there.

rcu_dereference_protected(phy->pib, 1) expresses that there can no
longer be a concurrent updater at that point; the protection condition
is the completed unregister rather than a locally held lock. The value
is only fetched so the final object can be passed to kfree_rcu().

rcu_access_pointer() would also be sufficient for that limited use if
you prefer it, and I can use that spelling in a v2.

Thanks,
Yousef

On Fri, 03 Jul 2026 13:15:46 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello Yousef,
>
> > @@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
> > list_del_rcu(&e->list);
> > hwsim_free_edge(e);
> > }
> > - pib =3D rcu_dereference(phy->pib);
> > rcu_read_unlock();
> >
> > - kfree_rcu(pib, rcu);
> > -
> > ieee802154_unregister_hw(phy->hw);
> > + pib =3D rcu_dereference_protected(phy->pib, 1);
> > + kfree_rcu(pib, rcu);
> > ieee802154_free_hw(phy->hw);
> > }
>
> Would you mind justifying the choice for the _protected() version,
> please?
>
> Thanks,
> Miqu=C3=A8l
