Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0138BF69
	for <linux-wpan@vger.kernel.org>; Sat, 18 Jul 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377247; cv=pass; b=S8tP4yySAZap8PpBBCSppkARoAab0joeoptBC7lw7hS+0r+96eHLCdXkg8DjVcjRA3fQunIqtqfi17jjjFlDG6M/hbCuhs83oXsl4lIcEzRGryDm6odkHuT7VBzDAOFGkf0BJu7yxAJPTj4Vxwob4SCHTvZ2LjimpSwmA9H09EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377247; c=relaxed/simple;
	bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrPXXG/tu4m3NWSij6GprKt8LfzdcxWyKZEOmYI/OC/eK0CeY0Wuvd89U8UBvMNZxOj2/Mk/JQ3ur56d/6+vedAu0M//B8Sox9r+MFKwU9FG/cqC7vkyC221M58WGHxeKC7OpP2U1GxvlAf22tOqQxQSW3rQxC8Df7hL+h9JGBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAtnHNhz; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAtnHNhz"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664d530fcfdso12540819d50.2
        for <linux-wpan@vger.kernel.org>; Sat, 18 Jul 2026 05:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377245; cv=none;
        d=google.com; s=arc-20260327;
        b=IRegKKkYWk9zm09cMJ5Du6OID0ZEzRt0vKjJ90igUolNd5AZatfOSLHnEUgQ33evkb
         DuYh/1ciyZsYFsW9PfSmsIsooOraeEQztDoqrKTAOKfqAn3YZjz5DT3LeW35uAPfEcTz
         YMml8HENzrot67jFf2fDBlb3wFJiD1UwZX04OEV85/RfGn3rZRIPMAR94shjPj1YerjF
         546iMQ+zPz/l5oUlaRlUg6pcsdHjdkLVqKnNSY1Z+82qS8zZp0YzZIcr9qGGgWB0rttK
         IovMksaQTOeB9aLUfIeawlTvmRPMKAjqoST0qVhPo5O6xlD0kpQ46PMD0i4knIVkWv8E
         QLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        fh=WBOW99j52IS9sF5ZyA2oeQqvtaGk884/SlGjsMWSxp0=;
        b=ptgyRQRvkYh2sS9LEt8uSm/8qgjyLCci21l5w+2mDEI1Nldc61srvX9PLRU2INu1zV
         wi4/9AcCoGj9BKmwlyezlohySgwuaITZuugwjieha1/ibGdIBgucS9oCSGTZ3qTdZhOs
         9KaWutOuwdoAL7ddXVfyanlBSiCknxypZkZXooZpPQitI/x7ztN91inYHaQsf8BRLQpf
         bajbe8UIG5cw5RiBiQ9Gii14Ayg9HJt7+8yEvJ1I9RM1fU8R2VT6FhDZEzzZOJezy201
         IzhyzhJZtla+kqKgo0eHAgXaVp1Mi07wrzFOYEmQ4ZWwGXogPrdpKgm9Z/d9LIdCvR3d
         D5lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377245; x=1784982045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        b=MAtnHNhzccMGUs4uTjV2XwV6Fkv3fAdVqmQ+HmQ0dECLMuMLnEFFV4Uvq9i+q6gJTC
         Hu9ic5enCL9dRLYbCtEmTJ+tCHQF3L6HU52di/MC3gjQjhVFUo5kNxvh+wRgrgyH7mQg
         sN6UGjK/3/IlCCLnU14g8mLMzuwVb5aiow4lcPA6S+fiJfe5nD47X8AAIFJDPFv+3RhI
         Na8BzJuncEXX3aUsEivRS+Tngo02o6mV4HR8c0UwOsv/UvGJ1BYkdI8R6AxVtJWxWxJC
         nksNYqqHLf41BmvN9y5LHUmLQod60o+fBuYyPBH6iFa3RNxLPkR/z9qcdco+5UqT6YPg
         eYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377245; x=1784982045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        b=KWAsAzgPszmEbBeR/1ob7wQ+LGjHWTb154fP5LudhVMeoBZFo+XFuH2MX4k61m2fMF
         xvv4utaw0ACJsjhNsIA0UpxW8OtA9JWAmdA7ecAeAM2GouxlxWuWEa62o/7hmDIjGJ4Q
         uzWpBCQjASMTsOIvgJhmlMr6vJMzjqpHtVniRJYhsFIbPYY3n7+x5COw8SEW0v6OuR9R
         IdpLWP57e63CokCxsVdAIaAaBx2VOsoRVzq1viSzIdfM2/EDu9KqiR4h5sEhsf/2Ye8P
         kqbzPh3H57XO8DDBJqwhKtrI2LEWx+6BWrDyDnV/8hvTF1i0pUmjrWhcH3x8xT35oUok
         nK/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLaSYiTRgn0U4KM5+0X3QWvtuhN0o1vTYI7O6dqTR7qlK6Y/H8bu+LhXREFXDyFlkB/6ltbS7bnWNy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6ASTQpDafZVEVCbj2GeC3r//wTbxce4JhKtbyc9BPLERPCJF
	8QZykx4674iWnKmV4vvvP8sqbFw1ysLn8KnqWVEOXCVbXVgTsJJ1ONLPwwDNVAqFsYabymjXfmj
	TgUUOdZ7ONrYYg+NAVikWtGkcKF7Ftwk=
X-Gm-Gg: AfdE7ckJ8Cb65vfc5pAlLI2r5aAjd/pt3b8lVdUHo7pK/JVt3eu7QWEXfirglBqXi+k
	minc5714mAbOGmg0kYp8wLkJc8EZPfEFtdnDUgWeiHA26N0hhre4fn8rMFa3dAshhsKrkjJOIHz
	WCYm4l011SQ/1lyJX+LVuN4a9OsDlzpkCLSMEMNbEnAklwETvElg51BrF+MpD1khGucc0wDhNym
	DqdKKzhEUvv6gjmCBi0kw1ni9aNGij5fYoxI056SQoITHsqQpVao9JG+gy7ccUV9X/qYPw+
X-Received: by 2002:a53:d24a:0:b0:668:ba3:fbe7 with SMTP id
 956f58d0204a3-6683bd99f2cmr1268824d50.93.1784377244920; Sat, 18 Jul 2026
 05:20:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:42 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:42 -0500
In-Reply-To: <87jyr8jgr8.fsf@bootlin.com>
References: <20260627235805.17310-1-alhouseenyousef@gmail.com>
 <877bncnx25.fsf@bootlin.com> <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
 <87jyr8jgr8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 07:20:42 -0500
X-Gm-Features: AUfX_mz62dEF0Vq5bXVUAbEJ8S4AYECuR0xq5pd1LEcB8_UKBr09Lg_v4EYwfJ0
Message-ID: <CAMuQ4bWObh9FVFifH91UMcdugn6YD79T1wAqeJ2owBnzsMdnCA@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. I'll use rcu_access_pointer() in v2; it expresses the final
pointer fetch more directly once unregister has quiesced the updaters.

Thanks,
Yousef

On Mon, 06 Jul 2026 17:10:35 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello Yousef,
>
> On 03/07/2026 at 04:19:42 -07, Yousef Alhouseen <alhouseenyousef@gmail.co=
m> wrote:
>
> > Hello Miquel,
> >
> > After ieee802154_unregister_hw() returns, the driver callbacks that
> > can replace phy->pib have been quiesced, and hwsim_del() has exclusive
> > ownership of the final teardown. The pointer is no longer being
> > fetched inside an RCU read-side critical section, so rcu_dereference()
> > is not appropriate there.
>
> That's right.
>
> > rcu_dereference_protected(phy->pib, 1) expresses that there can no
> > longer be a concurrent updater at that point; the protection condition
> > is the completed unregister rather than a locally held lock. The value
> > is only fetched so the final object can be passed to kfree_rcu().
>
> While I believe this is indeed true, it actually feels slightly overkill
> since there is no updater anymore and, as far as I understand, the only
> thing that we need here is to get the pointer value for freeing, right?
>
> > rcu_access_pointer() would also be sufficient for that limited use if
> > you prefer it, and I can use that spelling in a v2.
>
> If you don't mind, I feel like rcu_access_pointer() is exactly what we
> need here. It is also more understandable, even though I agree in
> practice there are no differences in this case.
>
> Thanks,
> Miqu=C3=A8l
