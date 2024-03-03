Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9727AE56
	for <linux-wpan@vger.kernel.org>; Sun,  3 Mar 2024 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508017; cv=none; b=BhaSii2rD0Ef/QusPTRHNQc03Y+ujQN+kY+CSIZ9Ch2cGPbuFe2t6hws7/z9+IvSggaj8YNk0ySHgVGpKRTDTOtwPBnefujW7gMC8YhRV1x1cM5wAkaKazMCgK+lrKOr5VGqEQS2A2ARBqgw6D9SRa4dWeq4SoWk9OYAzPg03oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508017; c=relaxed/simple;
	bh=zjXtMwgm/eHxKWyvHY2jbG2xbcJeROt0u/i/F9exbPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUKExfgYR3DbhFdEUr4rS+XVPyQnoNral8c8ajzXNSkuSFbrHC6H7V9SshIXaNFtsyMu/amR9o1K113tvCDPlu4LcT1FeAPOftV9PU/ZiGSfg+uR0+DKfGTuoJgSzbsq5YRtNUikpSkY+0gA71xoOrEaM5xk1ObFFfduChli4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Amqxjw5T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Amqxjw5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709508014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIpQyIQBDU9IOQzSfvK3GFtVhA/ANBUgz5c/8nKdj3g=;
	b=Amqxjw5TLyQDdyYonAEAYDpX2Z+qlN9p2vtRL8d83EnmRXc11LFiYrfF3EtyJdmoSlDwo2
	2ueATUzhQ+AuJwBxUz74F7aW4FxydsioJ208mdoxjMk/qQSlYYVTLNNCz6/wk59E2iOZze
	NNM2PTUWgJTVnrKGz1nQWZDCq/lnxwU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-HfqDbsNmP8exvodS-4aKAA-1; Sun, 03 Mar 2024 18:20:11 -0500
X-MC-Unique: HfqDbsNmP8exvodS-4aKAA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2d59be640so31079381fa.0
        for <linux-wpan@vger.kernel.org>; Sun, 03 Mar 2024 15:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709508010; x=1710112810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIpQyIQBDU9IOQzSfvK3GFtVhA/ANBUgz5c/8nKdj3g=;
        b=XBYkqFuwObp+OuYY+fJS1TmdRMkXw2BGOmTZJ7V0L3AUGj+EzCH8Zezz7OA8vkZnIx
         agop+QBGqxHn7JDPdKd33ZRpeRF+ICa4elarWswIqQ2BFGRf4vTUxUSAzJCQylCqAyt2
         dfNCur4BZMPBqLuK3dGUnN5omLjB4iP2TbW4pe+dhW8G8CwWMxhQ61/R5mjkeCcX6/Ur
         YA/XlZuBnox6D0p3FyX1QIWe4fRLPb8p9Q/SpgKx72z7hgbq9sX/C31L73iIHISm/VAf
         7B8KddiNprTecM382P5IBfqOahMpUTDk9QGVCMpIx+Na1EgSYPLKfepH76W18R+ghYya
         tPEg==
X-Forwarded-Encrypted: i=1; AJvYcCWJNFfvjEjYihLjbeEW2W2M6dD745cuDTL2ygAn55eNhKp4kNCI6ERRKvJ5CEGxrz4umuS5WYDEwb8jZwsESrIsvYEP07cHENi4eA==
X-Gm-Message-State: AOJu0YxASfNPcC3Y2lJyTuUzCElTHUoL8H9ZfkHwp+eAYMhbcnk9zq+T
	zB9wDtpAozhcXALzghGi2KkzbhrJVWtzmDSMCe6V4UitoxRr6+l6KSbB3WfxdrZlKa7dVBoiKhL
	xUIEsk5RJT//WZfR2bcO7kGHMTFudz4RQe63i8hEblheS1GMj/WU4UEnZCTSPmo/Nh77JP5LsTR
	KIZKUdm7/jwsJEZ07fkWNcD6TbqvWb2A8TjA==
X-Received: by 2002:a2e:3e1a:0:b0:2d2:4108:72a with SMTP id l26-20020a2e3e1a000000b002d24108072amr5378104lja.12.1709508010308;
        Sun, 03 Mar 2024 15:20:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqegTjHz0uMNE/MlJaVD6yU0I6oHvQsWJ6t6xo+KrbnXqRSt7ZzmH16ZBM718PcaVKMvelDgT3zIbuWZOy9Co=
X-Received: by 2002:a2e:3e1a:0:b0:2d2:4108:72a with SMTP id
 l26-20020a2e3e1a000000b002d24108072amr5378101lja.12.1709508009972; Sun, 03
 Mar 2024 15:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228163840.6667-1-pchelkin@ispras.ru>
In-Reply-To: <20240228163840.6667-1-pchelkin@ispras.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 3 Mar 2024 18:19:58 -0500
Message-ID: <CAK-6q+i4v94uF9BEeZ0zNWtutOn35pzstiY7jMBetCJ0PHOD3w@mail.gmail.com>
Subject: Re: [PATCH wpan] mac802154: fix llsec key resources release in mac802154_llsec_key_del
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 11:44=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru=
> wrote:
>
> mac802154_llsec_key_del() can free resources of a key directly without
> following the RCU rules for waiting before the end of a grace period. Thi=
s
> may lead to use-after-free in case llsec_lookup_key() is traversing the
> list of keys in parallel with a key deletion:
>
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 4 PID: 16000 at lib/refcount.c:25 refcount_warn_saturate+0x=
162/0x2a0
> Modules linked in:
> CPU: 4 PID: 16000 Comm: wpan-ping Not tainted 6.7.0 #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x162/0x2a0
> Call Trace:
>  <TASK>
>  llsec_lookup_key.isra.0+0x890/0x9e0
>  mac802154_llsec_encrypt+0x30c/0x9c0
>  ieee802154_subif_start_xmit+0x24/0x1e0
>  dev_hard_start_xmit+0x13e/0x690
>  sch_direct_xmit+0x2ae/0xbc0
>  __dev_queue_xmit+0x11dd/0x3c20
>  dgram_sendmsg+0x90b/0xd60
>  __sys_sendto+0x466/0x4c0
>  __x64_sys_sendto+0xe0/0x1c0
>  do_syscall_64+0x45/0xf0
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Also, ieee802154_llsec_key_entry structures are not freed by
> mac802154_llsec_key_del():
>
> unreferenced object 0xffff8880613b6980 (size 64):
>   comm "iwpan", pid 2176, jiffies 4294761134 (age 60.475s)
>   hex dump (first 32 bytes):
>     78 0d 8f 18 80 88 ff ff 22 01 00 00 00 00 ad de  x.......".......
>     00 00 00 00 00 00 00 00 03 00 cd ab 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81dcfa62>] __kmem_cache_alloc_node+0x1e2/0x2d0
>     [<ffffffff81c43865>] kmalloc_trace+0x25/0xc0
>     [<ffffffff88968b09>] mac802154_llsec_key_add+0xac9/0xcf0
>     [<ffffffff8896e41a>] ieee802154_add_llsec_key+0x5a/0x80
>     [<ffffffff8892adc6>] nl802154_add_llsec_key+0x426/0x5b0
>     [<ffffffff86ff293e>] genl_family_rcv_msg_doit+0x1fe/0x2f0
>     [<ffffffff86ff46d1>] genl_rcv_msg+0x531/0x7d0
>     [<ffffffff86fee7a9>] netlink_rcv_skb+0x169/0x440
>     [<ffffffff86ff1d88>] genl_rcv+0x28/0x40
>     [<ffffffff86fec15c>] netlink_unicast+0x53c/0x820
>     [<ffffffff86fecd8b>] netlink_sendmsg+0x93b/0xe60
>     [<ffffffff86b91b35>] ____sys_sendmsg+0xac5/0xca0
>     [<ffffffff86b9c3dd>] ___sys_sendmsg+0x11d/0x1c0
>     [<ffffffff86b9c65a>] __sys_sendmsg+0xfa/0x1d0
>     [<ffffffff88eadbf5>] do_syscall_64+0x45/0xf0
>     [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Handle the proper resource release in the RCU callback function
> mac802154_llsec_key_del_rcu().
>
> Note that if llsec_lookup_key() finds a key, it gets a refcount via
> llsec_key_get() and locally copies key id from key_entry (which is a
> list element). So it's safe to call llsec_key_put() and free the list
> entry after the RCU grace period elapses.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 5d637d5aabd8 ("mac802154: add llsec structures and mutators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> Should the patch be targeted to "net" tree directly?
>
>  include/net/cfg802154.h |  1 +
>  net/mac802154/llsec.c   | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index cd95711b12b8..76d2cd2e2b30 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -401,6 +401,7 @@ struct ieee802154_llsec_key {
>
>  struct ieee802154_llsec_key_entry {
>         struct list_head list;
> +       struct rcu_head rcu;
>
>         struct ieee802154_llsec_key_id id;
>         struct ieee802154_llsec_key *key;
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 8d2eabc71bbe..f13b07ebfb98 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_llsec =
*sec,
>         return -ENOMEM;
>  }
>
> +static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
> +{
> +       struct ieee802154_llsec_key_entry *pos;
> +       struct mac802154_llsec_key *mkey;
> +
> +       pos =3D container_of(rcu, struct ieee802154_llsec_key_entry, rcu)=
;
> +       mkey =3D container_of(pos->key, struct mac802154_llsec_key, key);
> +
> +       llsec_key_put(mkey);
> +       kfree_sensitive(pos);

I don't think this kfree is right, "struct ieee802154_llsec_key_entry"
is declared as "non pointer" in "struct mac802154_llsec_key". The
memory that is part of "struct ieee802154_llsec_key_entry" should be
freed when llsec_key_put(), llsec_key_release() hits.

Or is there something I am missing here?

Thanks.

Otherwise the patch looks correct to me.

- Alex

