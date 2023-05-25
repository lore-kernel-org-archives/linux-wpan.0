Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F417C77B7E
	for <linux-wpan@archiver.kernel.org>; Thu, 25 May 2023 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbjEYOTt (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 25 May 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbjEYOTs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 May 2023 10:19:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571C195
        for <linux-wpan@vger.kernel.org>; Thu, 25 May 2023 07:19:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso74935e9.0
        for <linux-wpan@vger.kernel.org>; Thu, 25 May 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=wHkJLBUPHnTjbEYVjNmSFBfrwTo4TZCcKmMspyHDJqkEgtEn/NrM7MabqcVul3Nqno
         Tj3bI4zoJ6l4Hg9bQmHhQQbBhAlRKcDm8amOqdotCQ9oFlP/+FfObQ0hng3dnX7Q/MZN
         zgGYdbCaPMvQmlkltsmx7FD2VjtKEhvmJCJlXmwvBZuW6dSptjbG7SRNG1Fm7qQKN4yC
         liMx8NahKkYKHcLA5WQznaj+nl+rQ5jq8bHdUqe+SiABS/vuvAbc4CowJ81V9pztluPl
         E5+xBeURqDYhzDTgK1vcmxkBvMDxMcF/cgTRWGzjM42BHCjiZvvDd2GvPhq5Nbgt/3q2
         /3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=FR8Wne6mD1Y39gSX5K0eweBIAadTqomQx2QRgs0fIuIJ3DgoM3wqFrb7OGNxhVB4mh
         BMM3diS3kvBSKB8Kpy8zACiCQBYLn/HSdSEuzClYxEj2dsKfvk11Wn4JjaaxJNpr8j09
         NcWd4FE+ngPPBjt/GLJZunOb4XDFDUVKyY3GKXTavvrlBtuZO/PWzNmbRg99zydON3n6
         R38pbL7uUaEenXI5lMKSSx4l6vEEW9rc40RlLSc5F5VxQ81PHfBvsKf2155EZP3rC/Xd
         EJC++tn3DuWbW9bu0c9Rx1jiFnsl0QidAAMsH9HA9dhvW3kg8mbD521bRCVtxgcqCoUr
         i6pQ==
X-Gm-Message-State: AC+VfDywDQ2UHc+AX6zzHxyKiN7DHoxVmaZM3RgnbzPYeVzALe1/0mXg
        GgzbJpzd3ZM+masuy9qPSspjl1VK5lsulkpkKUk00g==
X-Google-Smtp-Source: ACHHUZ4KFnQzrzknp0KdGkKJEouEDAIY/mR2vIflKYoy2kK41wOoC3lIDyruRoVpOijJkXCW0hl4A17q3HS19WMLAxw=
X-Received: by 2002:a05:600c:a0e:b0:3f1:9a3d:4f7f with SMTP id
 z14-20020a05600c0a0e00b003f19a3d4f7fmr147224wmp.1.1685024384734; Thu, 25 May
 2023 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125503.400797-1-leitao@debian.org>
In-Reply-To: <20230525125503.400797-1-leitao@debian.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 May 2023 16:19:32 +0200
Message-ID: <CANn89i+neca0ApNxRdZCiTMkwy-5=0mnOMM=9Z3u78VPNw4_fg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To:     Breno Leitao <leitao@debian.org>
Cc:     dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
        Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Thu, May 25, 2023 at 2:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
>
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
>

 diff --git a/include/net/phonet/phonet.h b/include/net/phonet/phonet.h
> index 862f1719b523..93705d99f862 100644
> --- a/include/net/phonet/phonet.h
> +++ b/include/net/phonet/phonet.h
> @@ -109,4 +109,23 @@ void phonet_sysctl_exit(void);
>  int isi_register(void);
>  void isi_unregister(void);
>
> +#ifdef CONFIG_PHONET
> +int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)=
;
> +
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return sk->sk_family =3D=3D PF_PHONET && sk->sk_protocol =3D=3D P=
N_PROTO_PHONET;
> +}
> +#else
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return 0;
> +}
> +
> +static inline int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, voi=
d __user *arg)
> +{
> +       return 1;
> +}
> +#endif
> +
>

PHONET can be built as a module, so I guess the compiler would
complain if "CONFIG_PHONET=3Dm" ???
