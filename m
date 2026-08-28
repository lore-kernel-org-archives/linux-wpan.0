Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5175B21A
	for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903222; cv=pass; b=MVFAmhSQ8WcEMpmhv26WC1v5avxUkhPgSBgOUgiWNPEd4k5nZVY3u3xbWmSJwWdi8P03ReD4c83WBQaTUNjnhXvjoS0nSRFDoCP+2O+RnW7t/1Vaj1+2I/TDta3aX0nHOMx+x5IcTeuFV2MeMBKLdVPDykc8SmcxKsJoKkrcdrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903222; c=relaxed/simple;
	bh=3GG5nCWl7CWNpEuPnh5H8CvcMn1R+QCVr+rkkOznzJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm1eAUeD/ZTgH9irXGbhTo4e6P0B45qj/BiRCH5NG45b98r8UzLoLyvm9/+iTRQnX8p5CH1xsLwn1uhP/ysAqZmWBbfnE3gWGI7k/xubI5plw2hxfbxFOO2QzVC3XQb8gpgcNH3MYhFi/nxbEg85tkkjUdO+ad3rEDOtCWuleQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpaZ24s+; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpaZ24s+"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52b6543169fso4451491cf.2
        for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2026 00:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787903219; cv=none;
        d=google.com; s=arc-20260327;
        b=BpliVLlmhjsqs2VOozYmnuw1CyCTmxWYPuNEwD7DDWGXLXT3HuKPjqVnzKDX6fW7AQ
         wAsL3gjt5dY6/cfb+yFIvHWVucoifhq7oLwNi0feOUVEJdABVNyQGriPYqJt920fqSRm
         sVXzGLUtNYeSSJn4L3gKtG4+apRDIxzxseibX1884AGtnJkw2bfDSiJe/RDwtfUOnM36
         yfJ4ImxfkOJyvTWxoGQCZxPCP4EAJbop5CMv4BNi/De8VargVZucYCpnFM+tT08YtfuE
         RyC8KXS6cmI+0RJkAZm5/CNDAHog9Ba0GqVMfI7lKT6WVzJ/3nIWDLO7Bo+B2DOHaIhC
         B1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        fh=mlPI8wBGT0Lhi280qyCUopnk4h4VUMvQ7Tm2WqENd00=;
        b=A8rUFenmbpxv31gPFxdqLC4zNUTnFyl9/zT6dOsnx/eNa5t8ZZwjKnNFDLy5W7tQOj
         Nz6ASbpCweDo9j3ahNH30oYL2JQkamMjAQcV9sHE9SWTNP32tiFoX5bONiEJ58Om2X0Q
         bYSg60z4D68PegfCiDdLr9kOliw0BozIZZZcvY5mpp12ZaM8fIRj+tsi99ZTrrjcZJW4
         glPE897HFWUYlalDmSbOUJxJwiAu10gAHu/+Fwd5OJHxIvgpDPBKY+CphYC94fV0qgcf
         F7cUdAGNX77yZ2KVEs0dqn2JLfs1hRQhmQBWDjXGCV7nKaOf+6HTQIiyVfKEC4VK5iPu
         BIgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787903219; x=1788508019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        b=mpaZ24s+xTC3DlZXHXm7u1inCSU1TBb+bXkcKbLvxbSnGRQZsqDQVNUuWYlCTdSrbp
         KNC/lVfmaM7ehg+Hv5ZGuLIycZ6WYg5Ri/fjRfxlvpM1eT7m/O1CMupJl2qeM3ZEgecl
         8UB+iEjNAYbSbgLy14TBsH6/6aXc5F0P1rfBa/jiZ30/mhH3G7ksCA1sw03ggyUfJ0Yf
         D+S8C+rcLNZ+KDJqjUYzrsJeuEDYQMvqrbQHn4ATAMAFUg80O8ywu35WZ1F88HrAmI6g
         f69hmISoZyeRK8XGKcEz8JhECQtOM+2RwoQx2HvegpS3jeQ38A8BBba/XSaU6rwsAykZ
         vrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903219; x=1788508019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbXs5Y0cN9WnX4kVJwxocnUX7LwdYJ30DpFpjvFGAsA=;
        b=rF8lxntWfIdbe3GZUSkJ5pA93TTwsz07hHKP65mA/6UdNAmMwzfv5DL2Uk7YzL9cXf
         KHo0A0LcQQ6JKfT9w45UANG4J6jQBGpQ4OMK+RtIYYjf4PIlRoh0ZAuo7CKGFMHiy6fO
         36TU5Wvkci15Vxi72mooKhMEac4Q/aFUqv/ToaYdBXW68kmQm1XybvXAlh7dmZRAgzfY
         5WOUuj0LYhHPmQFuboRwwtV8HEbTzMsa/yfpHjhOP2S2+ZUi7Td63oRRrMv6lXh4sxU4
         6iPRf44qTZIOqilD3VXnWxeGc15PSuHKhg8oTZEbIB4eUZKcc9OE5oXgsU4e0ebqOIDq
         HKxg==
X-Forwarded-Encrypted: i=1; AHgh+RqmgVoXxz686qOFyN1+bEiFwzAdhMNl2I8kmzz9iEJ22B9ChZ1H+VN6LVQQ/3i/pZWlO35gQa/i530f@vger.kernel.org
X-Gm-Message-State: AFuF++kfRaYPCWnK2SYOzYTz1vYJgldZpVWHM/Kks931pgYVzm5cdQVZ
	Xm6fKYv+QLtJDeEUaBpd8aSCeR+QQO02HfwOZE0XtGrDfkVUy50nFNuHHoq6/GeIXsCsYLERSVb
	UTIhgVBEyzSaoRhWCVkF7tSbmlbrqenQhlshq4Fo+
X-Gm-Gg: AR+sD112buk0X9CKFzLVgv/7+/jdhVxKDhHfVr9/r2Bmu1O/SfCn3KBSFmkBrZOq/Lg
	jVV0Q/V+KwlGALr4JmUp4gD5tqxj2q7VG6XQZ02GeJ4sl0YGcZdq/i9OLKopAaCA6Pmizp701o9
	CENO99z/ZhzmXYDrJpAX0V9f/ChJ7VBrGD1Zcuoz57JDz7oOBc/mJTi3r4LkdzZ2j3exYYsqVbM
	1BuKWCFdU2jn1Qcp9sRmUjoNKnuEYShPNg0MSNqiUHPXs5pdAoq5K4b5NIhdPx4W/lwwopVf1Q7
	eVp1f9tFWxE8yN4FGI3RyMvhgu6Ba2FEDFzhufl4qbR+pJdKlShIyJnye2CB4rFhfnufXgtTwcV
	T0uEZhUd3UhI/NyPQ/TN5u/x8HYmaM9rLm6C5KO1KJ0To4s790ax0W+y/mUk=
X-Received: by 2002:a05:622a:22a4:b0:52f:b6cf:9143 with SMTP id
 d75a77b69052e-52fb972a984mr54680621cf.40.1787903217808; Fri, 28 Aug 2026
 00:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
In-Reply-To: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 09:46:45 +0200
X-Gm-Features: AcwNN1UOB9k5TEE0jJdEjzh_hJz5U_4kim7pOPWMRfNF5Q5U3YnZhx0WKEOSVbY
Message-ID: <CANn89i+rDqRXaOO2FNpX57rbgVERrBsj6=OAoMU00aeejYk27Q@mail.gmail.com>
Subject: Re: [BUG] WARNING in lowpan_compress_addr_64
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:22=E2=80=AFAM Farhad Alemi <farhad.alemi@berkeley=
.edu> wrote:
>
> Hello,
>
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/182-warnin=
g-in-lowpan-compress-addr-64/
>
>   WARNING: net/6lowpan/iphc.c:937 at
> lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline],
> CPU#0: syz.9.76/13660
>   WARNING: net/6lowpan/iphc.c:937 at
> lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952, CPU#0:
> syz.9.76/13660
>   RIP: 0010:lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
>   Call Trace:
>    lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
>    lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
>    lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
>    lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
>    dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
>    __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
>    packet_snd net/packet/af_packet.c:3082 [inline]
>    packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114
>   Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Our reproducer.c is available upon request.
>
> Happy to test a patch if that would help.

Thanks for the report.

All these WARN_ON_ONCE() are bogus in modern days (panic_on_warn being
used by fuzzers)
Developers probably used them to catch unexpected packets.
Guess what, fuzzers do exactly that.

Also lowpan_header_create() seems to incorrectly return 0 instead of an err=
or.

Can you try:

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 37eaff3f7b6940b73924c38c360adf482d6cceab..dec04f63f1b2599a7291d020e66=
2f4d129333c14
100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -180,8 +180,6 @@ lowpan_iphc_uncompress_802154_lladdr(struct
in6_addr *ipaddr,
                                        &addr->short_addr);
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }
 }
@@ -820,8 +818,6 @@ lowpan_iphc_compress_ctx_802154_lladdr(const
struct in6_addr *ipaddr,
                        lladdr_compress =3D true;
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }

@@ -933,8 +929,6 @@ lowpan_iphc_compress_802154_lladdr(const struct
in6_addr *ipaddr,
                        lladdr_compress =3D true;
                break;
        default:
-               /* should never handled and filtered by 802154 6lowpan */
-               WARN_ON_ONCE(1);
                break;
        }

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 4df76ff50699ede5c187c9cca6f0cc10b19d2123..9bffe01cc448fcb993883748f35=
9cc71b879a729
100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -47,7 +47,7 @@ int lowpan_header_create(struct sk_buff *skb, struct
net_device *ldev,
         * if this package isn't ipv6 one, where should it be routed?
         */
        if (type !=3D ETH_P_IPV6)
-               return 0;
+               return -EINVAL;

        /* intra-pan communication */
        info->saddr.pan_id =3D wpan_dev->pan_id;
