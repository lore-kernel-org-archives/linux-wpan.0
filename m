Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13639282B
	for <linux-wpan@vger.kernel.org>; Wed,  1 Jul 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942601; cv=pass; b=nO02ilXHd7nTFnx3MtnzrohtC/xFATK9M2VZGNHMFMStsEdcZzgMR3dJbO2K+UeKQmCjPp0K7u7XTuGmmPm+nvWki1dOUHsmWvaQiXaSN5C6tNAhnoXGTfp9+bU+WVJWyIDFphxrgl4sw3pJzBEK/EP/Cq1MSkAGMpB9wPXv234=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942601; c=relaxed/simple;
	bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHw8fu0DQkNWb7CPLpu5UYDtfZHUWoT68BZhUsUPhMs/PmFXJOkGG71zgBDdozBmrAfC+vipZAlF3HDNvni8NQ7Na1LvDj4mEyGtTiCuegQIgQrPCQCBxMcsKMAPAOdMOT2XwlvUl/+hh5DISFXzfOqk4dtceIdTcdM4Pl9BW+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeIKBZup; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeIKBZup"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so9989055ad.2
        for <linux-wpan@vger.kernel.org>; Wed, 01 Jul 2026 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782942599; cv=none;
        d=google.com; s=arc-20260327;
        b=YO8Nwua6Z/wjFal0qsVbt5QHXHcbhG3gmYfPk0ttg1BP33oWnIjy/aEOiV7CPqGOaw
         FAHUZMdroX8Gql8hNxUrvtJQGuWpwSclGQEp/+CqVwGwZVtRuuFtNWrVWwAavJKOk+uG
         8/rphePCSRVXgplE/Q+qnMOD3D7wJovIRar8ukVrsf/aJZdXermt4aWApDSf0BvbMGKQ
         O+glUK4xdXZdnzAKn6m2SVOSqad+lgibJot1x1V0A6e8BhDNKOVhr3RF83vzObBhkp3t
         UWVtkbxK7nub+wdQ8amGC3UF6naZ7TJIwjSosLWafKczyj8+m9Q7nPcU2RWTst7y8rfb
         8dQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        fh=/FEbaAiGYkzKDR3RWXie/Pu/s9QsSzorHdLgKAwoM3A=;
        b=NcD4JFT3um72SxlEFmGYTJI2fHHar5apFUxAan1hIJiqKXvBg1qFb/LoNzNP1I/Kn5
         SJY4PS9bFYKoIvgWdDz7/3DRX1c4HB/B/js1dtOzwB5jGxUzC8GwENXTXhmdH3pHgfUO
         caBiepqK3LXmO/zLRx5htF1RIPaiwsRAzWF0Vh0J7apZ9CSCLmEk+i9pzV1UBFIn3Iua
         6QqSdjm957Crik6F7Clf4HWhdgdhqYgEUbYJWiLoi/Xoj1ZX1UHoHS27BpEvJZ2OE3Oa
         fMrqKB4+moDaL9paAQmw6awKuzB2jY5tW8sTdWbwLhPx8MuQGbP132WIxoTrbFsCXDUz
         k2ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942599; x=1783547399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=jeIKBZupD2uAFmiEql0qVzN7IsZ7fqEk7kqd3Xa8BaERaWr4+og89gsNp5WZcA035a
         ++rqwxuSPoKYVqZOKAl6tEPV1BjifyFxTsI//o6zH+qZM8QMS483DAtQrPyZecFIvAeI
         b4Uv0Jd8aD98+ylnQxMErKttre3lbD4XqRGRybrIwKkjzVvU1zw+nkclM9KnpYIOshQp
         KclDlGFZfHWmgwHqlv2JancioAwF5uQMhBqlcBGlDLeiK6xnRpJPTDdLx5u0tBgEiGSY
         wHvIrbMqOWMBIjdTrJgJ5WJUU6IX3QFIUgQLx7JnLuJp05H3x+EGriKl6O/SAwu6++M6
         uULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942599; x=1783547399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=bvumbVkLVP6kjRLr2EnZxYujiW3bJogOPHda776ONgdnxSVdnVOEI1XT+jdfe75uZu
         +m4uVYlzVWJG4F3UWBKoYmdt3Gpgosbgn5BNUiuDyaZwRUE4eFi+LzMF7T2CxtEW/wbA
         X+qg6Mwp8LkQ5pvVW+RdaPQYMJfhIJDcPz8HlYRMuK0Xq+1EOyesOGAV8eLsRwm3JX7N
         owvMR8KOmOKVcLJQLc/vBezMdyzdsio5zm8nNgXNvOWrXIQouqB3cHd4lEzaIudgdG8G
         8INths1DxiZaKJ7lgo4BuW8sHkPTw73ntoxvwHGtHRWBEVxtGEMTlQT74GxWCSjmCa2Q
         5A6w==
X-Forwarded-Encrypted: i=1; AHgh+RpThMGTV++TtiRy3M4aWXnoe8PBD3MwNvINFUrdWAHqAbKlPNCutVJ7sSc4ju/kdNNyqp5QS8xxV25a@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuSlcOyYSjY8mZYcxNLiuTgFefqMwc5hv5Yp4sEQnm+uTYjJA
	b06EiM+USaZP1txrnzGC230zWRIopF73Tm1EWRwGsYolrlg17kidf7S7QiWqhQ6ddD/rNsyyjdy
	Hi1D6lw9QAzR4L5B/kMK7O2XJO8JEC4Yd4WCA260m
X-Gm-Gg: AfdE7cmh/F969nN0TB1dubeuC51ygNpofHk/DmPn8uMrgtJbbUbuzRQwJ5KHbPULgKq
	pCl3klICJ+sxnuVAHkx7zV3Bpcnfx47vmbk2Fi/epzJnERomJKBwogvn7yNwZfxaaCj5covEiZr
	mLdqp3fre1aRjJ5clj36Ru0PZpIt0CIfssva/apNqshRmCoh2wBCdZ2CFt/ycrK2uaVd/twOq7E
	dy1uKiu2ioM+f4GZYGF+KEVGZd0MT//afKnOZgqepVf8ZJ+y5puSZB9ATdFe6NLnxnq5FFNyiFI
	iic0orRSQPyA6BqBzuAhNoZoiotRUDDT9TLOwRFQRT3N62GLxfb7dRE/cfd9CebAL4UM/m+ihFm
	ofR054bi9GErD2YENL7I8QnCeIw7Dn2TNmajsz07gWA==
X-Received: by 2002:a17:902:e807:b0:2c9:97a7:71ac with SMTP id
 d9443c01a7336-2ca7e91c1a5mr36388505ad.39.1782942598927; Wed, 01 Jul 2026
 14:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630211808.50440-1-alhouseenyousef@gmail.com> <20260701164222.9094-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260701164222.9094-1-alhouseenyousef@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 14:49:47 -0700
X-Gm-Features: AVVi8CdoooCP65yZagy1IFzbbVt52lLnQXjOFVI1HQAUaxbpxOSVlznX-wwdP2g
Message-ID: <CAAVpQUCfzVMV4NZPnTGB7RFCxrBPHET0sxnAoO6zKuUNZaFTRg@mail.gmail.com>
Subject: Re: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, marcel@holtmann.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:42=E2=80=AFAM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del(), so an
> asynchronous transmit completion can follow a poisoned list node in
> ieee802154_wake_queue().
>
> Use list_del_rcu() as in the single-interface removal path. The following
> unregister_netdevice() waits for in-flight RCU readers before freeing the
> netdevice, so no separate grace-period wait is needed.
>
> Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface=
")
> Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D36256deb69a588e9290e
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
