Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822811CAB8
	for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920304; cv=none; b=UzPoJrqNjd8b/zu1Y8ZrV94KrHSXknf1+tijsD4hTfSSk5R3/GtlIR5NWakp4tiAjlzlG6ABhXuk5v5nS6wE80P/yCFhELVEaeelbDW3dUxw2JauSAmnQKyHq6yNG/qRAzOJOiTt/7d8Ye0jdcQTyCKRN06gJ4o6qBg+m02StqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920304; c=relaxed/simple;
	bh=wnFLfn5BeeZ3wPCN20V30mk4CTpYaz6K85DjdS+HiHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VWT0TCBDX1S9tOoyPsVJzYMQCQhpUcHRU+PjD1N9uZe3BGUFn1LV58gTQ+rNe/iVgw6hBnoCsXsf7oP7b0bbVhZ2NbWLI4vLLsSCMeHdcL88NXmkLpBgr8O8omTvKBtfdqW9L/0UQoBqNDdheqd9knTwuJ3BhjZowC1+xqaS2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JJP39igI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JJP39igI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d325beee2so2682767f8f.2
        for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920301; x=1729525101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHzMyBjSo/EDcGPVYKinoicVUAUc6s3aklub75jR0Lw=;
        b=JJP39igIjYtLhphYpdRanLZToLY8t29Od5fQ3cNLQlpEtOkd70DfFC9y2+RTae+bf/
         aGVv38VnD8A/SqcDsvUB/2BaO4erZMEjqzUJTY2KpYzbHuFneqWqkJuemj8nwmZcywRg
         UOCD+2/xcVoVam8A3vbALfUroDSUzcsxEmmai47j0QhHr71NgDnMoD2ExQH60Lp5zOcg
         Jl0E66/VWFg7fO78E5BF3Gk8VErtbtmOjWj29ARCWialCcNVlkzSobpBUPeQ4T1wCgy2
         UXPw5QLbPyTIQ6JRQZcW5gG9Sj8QYq4k9NSULBc8Z8XBshDd3nEv4B+g3If1kjidm9o9
         uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920301; x=1729525101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHzMyBjSo/EDcGPVYKinoicVUAUc6s3aklub75jR0Lw=;
        b=wGbBUft8vBeSb6zVRzAofKw8iuarNqat4mvQaYG62Mh0nLcwhXSIFD+zNDAMMZ69Qf
         WDAlvgWEax06TAAY49grdN3IzxFXc/fw5N39p+R4BA3TM0dBJk08K1UG9xXd5C31z+/9
         FL3TWHhj+ohJ9W3ZDm/7sJ4VjeJtoXZIsZQP7GTXOrGUyzzhHWJAx1ZlNo2m4bl3k5qY
         bIbjDqP5Jld7TUQGf0GH3YQjUDeCNQpt/rGzCWHC+R98jrAxr8ZxCpBZ9Jz0GPwn0jzF
         rzE6lWNcGRD74UEo+l6siuf4dgEXlJOCxb2zMmLBYLMBAaoqp7AevIj+VQoNc4+YsxdZ
         4EyA==
X-Forwarded-Encrypted: i=1; AJvYcCXJd5lMzcCOc2ePzTfiqXfzrYTsopy3D9DL5C+cfWWyBNzcPaKh6nw5fk+CK6eirpor9VUNVuo3ckPH@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTVn1ZJICB5Ha4UMJCmqwV6TzCrR9j7C0u010gtLmsBlaDMLt
	Ip2yFY6Qv5Kpr/YkP/eaRwGltZGJT743LdAqbD/bli/pNvbEHiKVYAEONG9LDOg=
X-Google-Smtp-Source: AGHT+IFTv9Ec0x1pgYaAzfXLeF4AIIb/MZM5qOa/pOg2VUZq5MjMIBM3l7s9Bf7wq9KEq9mdpqLhRg==
X-Received: by 2002:adf:f686:0:b0:37d:5232:a963 with SMTP id ffacd0b85a97d-37d5fef48abmr5709371f8f.14.1728920300822;
        Mon, 14 Oct 2024 08:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:20 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 0/9] do not leave dangling sk pointers in pf->create functions
Date: Mon, 14 Oct 2024 16:37:59 +0100
Message-Id: <20241014153808.51894-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some protocol family create() implementations have an error path after
allocating the sk object and calling sock_init_data(). sock_init_data()
attaches the allocated sk object to the sock object, provided by the
caller.

If the create() implementation errors out after calling sock_init_data(),
it releases the allocated sk object, but the caller ends up having a
dangling sk pointer in its sock object on return. Subsequent manipulations
on this sock object may try to access the sk pointer, because it is not
NULL thus creating a use-after-free scenario.

We have implemented a stable hotfix in commit 631083143315
("net: explicitly clear the sk pointer, when pf->create fails"), but this
series aims to fix it properly by going through each of the pf->create()
implementations and making sure they all don't return a sock object with
a dangling pointer on error.

Changes in V3:
  * retargeted the series to net-next
  * dropped the hotfix patch, which was merged into net already
  * replaced the hotfix code with DEBUG_NET_WARN_ON_ONCE() to catch future
    violations

Changes in V2:
  * reverted the change introduced in 6cd4a78d962b ("net: do not leave a
    dangling sk pointer, when socket creation fails")
  * added optional commits to all pf->create implementaions to clear the
    sk pointer on error after sock_init_data()

Ignat Korchagin (9):
  af_packet: avoid erroring out after sock_init_data() in
    packet_create()
  Bluetooth: L2CAP: do not leave dangling sk pointer on error in
    l2cap_sock_create()
  Bluetooth: RFCOMM: avoid leaving dangling sk pointer in
    rfcomm_sock_alloc()
  net: af_can: do not leave a dangling sk pointer in can_create()
  net: ieee802154: do not leave a dangling sk pointer in
    ieee802154_create()
  net: inet: do not leave a dangling sk pointer in inet_create()
  net: inet6: do not leave a dangling sk pointer in inet6_create()
  net: warn, if pf->create does not clear sock->sk on error
  Revert "net: do not leave a dangling sk pointer, when socket creation
    fails"

 net/bluetooth/l2cap_sock.c  |  1 +
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 net/can/af_can.c            |  1 +
 net/core/sock.c             |  3 ---
 net/ieee802154/socket.c     | 12 +++++++-----
 net/ipv4/af_inet.c          | 22 ++++++++++------------
 net/ipv6/af_inet6.c         | 22 ++++++++++------------
 net/packet/af_packet.c      | 12 ++++++------
 net/socket.c                |  4 ++--
 9 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.39.5

