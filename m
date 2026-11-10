Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321687;
	b=CTuqMn3du55NFEIN43N0gQXKrqc6XVMZGwg7uilpVH9ZASATiL5woSbc9OoGtzWNM0tN
	 +9ucjQBUTjbOzK5vL9yoWAppZojmkr71PnY3uMsJvlsZieHsOOfqHrb8dpdP+IgcSfbm4
	 wHY6TP0eLZefd9I5CNcorB5i4bOEK5QgXmusIgNTdHp2PCHcK89VAgR9j83xoDwhcmikA
	 Gyp1JE8eZwAKkfu3nBu0hOpCtQ+pltFdu6nadco3EGIxUloBihTgwRapM2QRZPebQ13t2
	 O7+MFQMrJ5hjPBy2TZrcsdo/ZrlmS39jziXc+B6dqjnvCa/TEvxIXNcF80JWglqeL7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321687;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TTm6kiQ7jtyAPcCMdJ4HrL7lFDse3/K7/p/AaBjxNSc=;
	b=1JWXBGPsALRwiSc5fGEdBPcHcLIX4Yuwv+ix++MvmRt/C1YyxlWd/uZn4WmsEkKJScmb
	 k+VZ7GvztM4nr1G9U0CXXSKkpuVV0GKmtnuBvlftgkCsn5XPp7ioOr4Pt8+fcet/hcPft
	 LlwXw3GKvgNwB4+9dS6A4p63TZEVV8XRavKmbOAG2eC+ZxyAIxYbxKvBOdgmVRDF4Wmui
	 Ae4yDyeI7Y608IeWP0FTdip1j2WqGhFrB1+f+mDmlPdYhfLAxmrdMqopbkaMNkZ5gEvyQ
	 xEloGZU9i08UB0xbYHKCOv034F5Z0TWOHAURS9Ns4+g77JYVGivmhYHUXN/+xgis2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0wasxwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AEC60A2619;
	Tue, 10 Nov 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0wasxwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E511F0089F;
	Tue, 10 Nov 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321686;
	bh=TTm6kiQ7jtyAPcCMdJ4HrL7lFDse3/K7/p/AaBjxNSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L0wasxwRyNyaZaSu5O40KQkrPdcwPwQDvnECjTlxCGp6xyeRZ4A3jc2KvBK4O/MP7
	 6bnETJhqvUXR8BZ+Da2ZWDI7eS3xYLLOAHeZX05ill9iztKetIoYXYNYz7hnRuzyt5
	 z8oN8snKA4wRnD5LQn7MJw186+gmyY0MDUKd5D/vTETBdxGDqTjLtST3uv+qg08ntK
	 LI0vMPh4b7aAVYdf+hOU2Dzl9lsqv+DH2GVNzbIFfIGjnPY/a05iu1NEm4t3Pa3RYv
	 NNG76tMvTr6LqpXWxFtIgRwUtayZpzkpusKdZxi2CPxbypQGojWGVWXuNvf3IqhMwn
	 7HXAK9xeYBm3A==
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via
 TUNSETLINK
From: netdev-bot+sashiko@kernel.org
To: skalpesh942@gmail.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Date: Tue, 10 Nov 2026 14:41:25 +0000
Message-ID: <179432168535.994134.12500013987740507509@kernel.org>
In-Reply-To: <20261106142421.17793-1-skalpesh942@gmail.com>
References: <20261106142421.17793-1-skalpesh942@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message rejects NULL checks in net/ieee802154/ and
  says it fixes the problem "at the source".
- [Medium] The commit message misstates the root cause and points the
  Fixes tag at the wrong commit.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but tun still
  lets users set ARPHRD_6LOWPAN through TUNSETLINK.
- [Medium] This problem wasn't introduced by this patch, but TUNSETLINK
  still accepts ARPHRD_MCTP (290), and an unprivileged user can use that…

--

tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK

The TUNSETLINK ioctl now rejects ARPHRD_IEEE802154 and
ARPHRD_IEEE802154_MONITOR. It also rejects any arg larger than USHRT_MAX.
The IEEE 802.15.4 cases and the <linux/ieee802154.h> include are removed
from tun_get_addr_len().

Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90

> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
> TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
> these types.

[Severity: Medium]
Is this the right root cause? TUNSETLINK has assigned any arg to
dev->type since commit ff4cc3ac93e1 ("[TUN]: Allow setting the linktype
of the tap device.") from 2005:

    tun->dev->type = (int) arg;

tun_get_addr_len() came later, in cca8ea3b05c9, and only picks addr_len
after the type has already been set. Unknown types fall through to the
default case and get addr_len 0, but they are still accepted.

The dereference in ieee802154_llsec_dump_table() goes back to
3e9c156e2c21 (2014).

With that history, is this tag correct?

    Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")

It looks like the bug predates cca8ea3b05c9. Removing the IEEE802154
cases from tun_get_addr_len() also seems to be cleanup made dead by the
new TUNSETLINK check, not part of the fix itself.

[ ... ]

> The IEEE 802.15.4 subsystem operates on the invariant that any
> net_device with dev->type == ARPHRD_IEEE802154 is a genuine WPAN device
> with a valid dev->ieee802154_ptr context.

[ ... ]

> Rather than scattering NULL checks across every site in net/ieee802154/,
> fix the issue at the source: validate that arg fits within unsigned short

[Severity: Medium]
Is tun the only way to break this invariant? bond_enslave() in
drivers/net/bonding/bond_main.c rejects only CAN devices:

    if (slave_dev->type == ARPHRD_CAN) {
        BOND_NL_ERR(bond_dev, extack,
                    "CAN devices cannot be enslaved");
        return -EPERM;
    }

For the first non-Ethernet slave, bond_setup_by_slave() copies the type
onto the bond:

    bond_dev->type = slave_dev->type;

Nothing in drivers/net/bonding/ sets ml_priv or ieee802154_ptr.

Enslaving a wpan interface that is down (from mac802154, hwsim or
fakelb) would therefore give a bond of type ARPHRD_IEEE802154. On that
bond, ieee802154_llsec_dump_table() would still run:

    if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
        goto skip;

    data.ops = ieee802154_mlme_ops(dev);
    if (!data.ops->llsec)

with dev->ml_priv == NULL. The nl-phy.c and socket.c sites look exposed
in the same way.

Unlike the tun case, this path needs CAP_NET_ADMIN and an existing WPAN
netdev.

Team already closed this gap in commit 9043be310c6a ("team: reject CAN,
IEEE 802.15.4 and 6LoWPAN devices in team_port_add"). That commit noted
that bonding only had the CAN fix (8ba68464e478):

    if (port_dev->type == ARPHRD_CAN ||
        port_dev->type == ARPHRD_IEEE802154 ||
        port_dev->type == ARPHRD_IEEE802154_MONITOR ||
        port_dev->type == ARPHRD_6LOWPAN) {

The commit message relies on this invariant as the reason for not adding
checks in net/ieee802154/. Would bonding need a similar rejection before
the fix at the source is complete?

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..f2915e929e395 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;

[ ... ]

> +		if (arg > USHRT_MAX) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (arg == ARPHRD_IEEE802154 || arg == ARPHRD_IEEE802154_MONITOR) {
> +			ret = -EINVAL;
> +			break;
> +		}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
should ARPHRD_6LOWPAN be rejected here too? tun_get_addr_len() still has:

    case ARPHRD_6LOWPAN:
        return EUI64_ADDR_LEN;

lowpan_event() in net/6lowpan/core.c is a global netdevice notifier. It
checks only dev->type == ARPHRD_6LOWPAN and __in6_dev_get(dev), and then
treats netdev_priv(dev) as a struct lowpan_dev. The header comment on
lowpan_is_ll() says:

    /* caller need to be sure it's dev->type is ARPHRD_6LOWPAN */

For a tun device, netdev_priv() is a struct tun_struct, which starts
with:

    struct tun_file __rcu *tfiles[MAX_TAP_QUEUES];

On NETDEV_DOWN, lowpan_event() runs:

    for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
        clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
                  &lowpan_dev(dev)->ctx.table[i].flags);

These writes land inside tun->tfiles[].

On NETDEV_UP or NETDEV_CHANGE it reads lowpan_dev(dev)->lltype, which
overlays tfiles[0]. If that value equals LOWPAN_LLTYPE_IEEE802154,
addrconf_ifid_802154_6lowpan() dereferences
lowpan_802154_dev(dev)->wdev->ieee802154_ptr, which comes from tun
memory.

The inet6_dev created at NETDEV_REGISTER survives the type change, so
the notifier check passes.

With the current layouts, each clear_bit() targets bit 0 of an aligned
pointer. lltype can read as 1 only on some 64-bit big-endian layouts, so
the crash depends on the memory layout. The path is still reachable by
an unprivileged user with tun in a user+net namespace.

Team rejects ARPHRD_6LOWPAN for this reason. Commit 9043be310c6a notes
that "the 6LoWPAN netdev notifier writes through lowpan_dev(dev) on
NETDEV_DOWN".

[Severity: Medium]
This is also a pre-existing issue and was not introduced by this patch,
but TUNSETLINK still accepts ARPHRD_MCTP (290). Can this hit a WARN_ON
in the MCTP receive path?

An IFF_TUN device registers as ARPHRD_NONE, and mctp_known() in
net/mctp/device.c accepts that type:

    return dev->type == ARPHRD_MCTP ||
           dev->type == ARPHRD_LOOPBACK ||
           dev->type == ARPHRD_NONE;

So mctp_register() attaches an mctp_dev at NETDEV_REGISTER.
mctp_dev_notify() handles only NETDEV_REGISTER and NETDEV_UNREGISTER, so
the mctp_dev stays in place after a type change.

Suppose the user calls TUNSETLINK(ARPHRD_MCTP), brings the link up, and
writes a frame whose packet info header carries ETH_P_MCTP.
tun_get_user() sets skb->protocol = pi.proto, and the frame reaches
mctp_pkttype_receive():

    if (dev->type == ARPHRD_MCTP) {
        cb = mctp_cb(skb);
    } else {

The skb cb was zeroed at allocation and no MCTP driver ever filled it
in, so mctp_cb() hits:

    WARN_ON(cb->magic != 0x4d435450);

An unprivileged user can reach this with tun in a user+net namespace,
and on panic_on_warn systems it panics the machine. Should ARPHRD_MCTP be
rejected here as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106142421.17793-1-skalpesh942%40gmail.com
